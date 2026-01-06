import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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

class ReadyScreen extends StatefulWidget {
  const ReadyScreen({super.key});

  @override
  State<ReadyScreen> createState() => _ReadyScreenState();
}

class _ReadyScreenState extends State<ReadyScreen> {
  String message = 'FinalRep\nReady to move.';
  final FlutterTts tts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  message = 'FinalRep\nStarting… let’s go 💪';
                });
                await tts.speak('FinalRep starting... lets go!');
              },
              child: const Text('Start Workout'),
            ),
          ],
        ),
      ),
    );
  }
}
