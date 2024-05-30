import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: PlannerPage(),
  ));
}

class PlannerPage extends StatefulWidget {
  @override
  _PlannerPageState createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  final List<Map<String, dynamic>> _plans = [];
  final TextEditingController _controller = TextEditingController();

  void _addPlan(String title) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance.collection('plans').add({
        'title': title,
        'completed': false,
        'userId': FirebaseAuth.instance.currentUser!.uid,
      });
      _fetchPlans();
    }
  }

  void _toggleComplete(String id, bool currentStatus) async {
    await FirebaseFirestore.instance.collection('plans').doc(id).update({
      'completed': !currentStatus,
    });
    _fetchPlans();
  }

  void _deletePlan(String id) async {
    await FirebaseFirestore.instance.collection('plans').doc(id).delete();
    _fetchPlans();
  }

  void _fetchPlans() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final snapshot = await FirebaseFirestore.instance
          .collection('plans')
          .where('userId', isEqualTo: userId)
          .get();
      final plans = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'title': doc['title'],
          'completed': doc['completed'],
        };
      }).toList();
      setState(() {
        _plans.clear();
        _plans.addAll(plans);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: Text(
          "Planlayıcı",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple[200]!,
                Colors.orangeAccent,
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
              Colors.purple[200]!,
              Colors.orangeAccent,
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Yeni Plan Ekle',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addPlan(_controller.text);
                    }
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _plans.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _plans[index]['title'],
                      style: TextStyle(
                        color: Colors.white,
                        decoration: _plans[index]['completed']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    leading: Checkbox(
                      value: _plans[index]['completed'],
                      onChanged: (bool? value) {
                        _toggleComplete(
                            _plans[index]['id'], _plans[index]['completed']);
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        _deletePlan(_plans[index]['id']);
                      },
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
