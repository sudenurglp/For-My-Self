import 'package:flutter/material.dart';

class TestPuan extends StatelessWidget {
  final int dogruSayisi;
  final int yanlisSayisi;

  TestPuan({required this.dogruSayisi, required this.yanlisSayisi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple[100]!,
                Colors.orange[200]!,
              ],
            ),
          ),
        ),
        title: Text(
          "Puan Sayfası",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[100]!,
              Colors.orange[200]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Doğru Sayısı: $dogruSayisi',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Yanlış Sayısı: $yanlisSayisi',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TestPuan(dogruSayisi: 5, yanlisSayisi: 3),
  ));
}
