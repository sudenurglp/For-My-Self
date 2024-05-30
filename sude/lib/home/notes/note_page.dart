import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Note {
  final String id;
  final String baslik;
  final String icerik;
  final String? password;

  Note({
    required this.id,
    required this.baslik,
    required this.icerik,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'baslik': baslik,
      'icerik': icerik,
      'password': password,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      baslik: map['baslik'],
      icerik: map['icerik'],
      password: map['password'],
    );
  }
}

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final List<Note> _notes = [];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    if (_user == null) return;
    final snapshot = await _firestore.collection('notes').where('userId', isEqualTo: _user!.uid).get();
    final notes = snapshot.docs.map((doc) => Note.fromMap(doc.data())).toList();
    setState(() {
      _notes.addAll(notes);
    });
  }

  void _addNote() async {
    if (_user == null) return;
    final newNote = Note(
      id: _firestore.collection('notes').doc().id,
      baslik: _titleController.text,
      icerik: _contentController.text,
      password: _passwordController.text.isNotEmpty ? _passwordController.text : null,
    );

    await _firestore.collection('notes').doc(newNote.id).set({
      ...newNote.toMap(),
      'userId': _user!.uid,
    });

    setState(() {
      _notes.add(newNote);
      _titleController.clear();
      _contentController.clear();
      _passwordController.clear();
    });
  }

  void _deleteNote(String id) async {
    await _firestore.collection('notes').doc(id).delete();
    setState(() {
      _notes.removeWhere((note) => note.id == id);
    });
  }

  void _viewNote(Note note) {
    if (note.password != null) {
      _showPasswordDialog(note);
    } else {
      _showNoteDialog(note);
    }
  }

  void _showPasswordDialog(Note note) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController _passwordCheckController = TextEditingController();
        return AlertDialog(
          title: Text('Şifreyi Girin'),
          content: TextField(
            controller: _passwordCheckController,
            decoration: InputDecoration(
              labelText: 'Şifre',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_passwordCheckController.text == note.password) {
                  Navigator.of(context).pop();
                  _showNoteDialog(note);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Şifre yanlış!')),
                  );
                }
              },
              child: Text('Doğrula'),
            ),
          ],
        );
      },
    );
  }

  void _showNoteDialog(Note note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(note.baslik),
          content: Text(note.icerik),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notlar",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple[300]!,
                Colors.white,
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.purple[300]!,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Başlık',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      labelText: 'İçerik',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 12.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Şifre (opsiyonel)',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 12.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addNote,
                      child: Text(
                        "Not Ekle",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.purple[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final note = _notes[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        note.baslik,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(note.password != null ? 'Kilitli' : note.icerik),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteNote(note.id),
                      ),
                      onTap: () => _viewNote(note),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
