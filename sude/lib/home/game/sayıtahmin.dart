import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class Sayitahmin extends StatefulWidget {
  const Sayitahmin({super.key});

  @override
  State<Sayitahmin> createState() => _SayitahminState();
}

class _SayitahminState extends State<Sayitahmin> {
  final TextEditingController _controller = TextEditingController();
  final Random _random = Random();
  late int _targetNumber;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _targetNumber = _random.nextInt(100) + 1;
    _message = '';
    _controller.clear();
  }

  void _checkGuess() {
    final guess = int.tryParse(_controller.text);
    if (guess == null) {
      setState(() {
        _message = 'Lütfen Bir Sayı Girin';
      });
      return;
    }
    setState(() {
      if (guess < _targetNumber) {
        _message = 'Düşük';
      } else if (guess > _targetNumber) {
        _message = 'Yüksek';
      } else {
        _message = 'Doğru';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sayıyı Bul",
          style: TextStyle(color: Colors.white),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '1 ile 100 Arasında Tutulan Sayıyı Tahmin Edin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tahmininiz',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _checkGuess,
                child: Text(
                  'Tahmin Et',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Text(
                _message,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
