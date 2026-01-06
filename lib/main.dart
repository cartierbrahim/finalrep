import 'package:flutter/material.dart';

void main() {
  runApp(const FinalRepApp());
}

class FinalRepApp extends StatelessWidget {
  const FinalRepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ReadyScreen(),
    );
  }
}

class ReadyScreen extends StatelessWidget {
  const ReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'FinalRep\nReady to move.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: null, child: Text('Start Workout')),
          ],
        ),
      ),
    );
  }
}
