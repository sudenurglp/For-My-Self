import 'package:flutter/material.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({Key? key}) : super(key: key);

  @override
  _MoodPageState createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  double _moodValue = 5;

  final Map<int, String> moodMessages = {
    1: "Üzgün hissediyorsun. Yine sevebiliriz şarkısını dinle!",
    2: "Bugün biraz zorlu geçiyor gibi. Playlisti gözden geçir :).",
    3: "Biraz canın sıkıldıysa aç bi Falım rahatla.",
    4: "Moralsiz gibi hissediyorsun. Küçük şeylerle mutlu olmayı dene.",
    5: "Nötr bir ruh halindesin. Biraz keyif katmaya ne dersin?",
    6: "Fena değilsin, ama müzik seçimine bağlısın.",
    7: "İyi bir ruh halindesin, devam et!",
    8: "Mutlu hissediyorsun. Bu güzel bir gün!",
    9: "Harika hissediyorsun, o zaman dans!",
    10: "Daha Mutlu Olaaamaam! Bu anın tadını çıkar!",
  };

  final double shadowIntensity = 200;

  void _showMessage(BuildContext context) {
    int moodIntValue = _moodValue.round();
    String message = moodMessages[moodIntValue] ?? "Bilinmeyen ruh hali";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Ruh Hali Mesajı",
            style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              message,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Tamam", style: TextStyle(fontSize: 20)),
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
        backgroundColor: Colors.deepPurple[200],
        title: const Text(
          "Mood",
          style: TextStyle(color: Colors.white),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                "Mooduna Göre ",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 2.0,
                      color: Colors.white.withOpacity(shadowIntensity / 250),
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                "1-10 Arasında Sayı Seç",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.0, 1.0),
                      blurRadius: 2.0,
                      color: Colors.orange.withOpacity(shadowIntensity / 250),
                    ),
                  ],
                ),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(height: 20),
            Slider(
              value: _moodValue,
              min: 1,
              max: 10,
              divisions: 9,
              label: _moodValue.round().toString(),
              onChanged: (value) {
                setState(() {
                  _moodValue = value;
                });
              },
              activeColor: Colors.orange[300],
              inactiveColor: Colors.white,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showMessage(context);
              },
              child: const Text(
                "Gönder",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[300],
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MoodPage(),
  ));
}
