import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Center(
          child: MyTextBox(
            text: '',
            sectionName: '',
            onPressed: () {
            },
          ),
        ),
      ),
    );
  }
}

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final VoidCallback onPressed;

  const MyTextBox({
    Key? key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sectionName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                  IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.border_color, color: Colors.deepPurple),
                  ),
                ],
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
