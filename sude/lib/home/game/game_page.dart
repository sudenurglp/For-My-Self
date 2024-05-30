import 'package:flutter/material.dart';
import 'package:sude/home/game/sayıtahmin.dart';
import 'dart:async';
import 'dart:math';
import 'package:sude/home/game/oyun.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text(
          "Oyunlar",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple[200]!,
                Colors.orange[200]!,
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
              Colors.orange[200]!,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              "Seç Bakalım",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: 'TimesNewRoman',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            ),
            SizedBox(height: 25),
            Padding(padding: const EdgeInsets.fromLTRB(160, 0, 0, 0),
            child: Text(
              "Hangisinde İyisin",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: 'TimesNewRoman',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            ),
            SizedBox(height: 80),
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Sayitahmin()),
                          );
                        },
                        text: 'Sayıyı Bul',
                        icon: Icons.format_list_numbered,
                      ),
                      SizedBox(width: 20),
                      CardButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Oyun()),
                          );
                        },
                        text: 'Test Et Kendini',
                        icon: Icons.quiz,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CardButton extends StatelessWidget {
 final VoidCallback onPressed;
 final String text;
 final IconData icon;
 const CardButton({
   required this.onPressed,
   required this.text,
   required this.icon,
});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 5,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.purple[400],
              ),
              SizedBox(height: 10),
              Text(text,style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple[400],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
