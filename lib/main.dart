import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinalRep',
      theme: ThemeData(primarySwatch: Colors.green),
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
  // 🔊 Text-to-Speech
  final FlutterTts tts = FlutterTts();
  bool ttsEnabled = true;

  // 🏋️ Workout config (hardcoded for now)
  int totalReps = 5;
  int totalSets = 2;
  int restSeconds = 5;

  // 🔁 State
  int currentRep = 0;
  int currentSet = 1;
  bool isWorkingOut = false;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid || Platform.isIOS) {
      tts.setSpeechRate(0.5);
      tts.awaitSpeakCompletion(true);
    } else {
      ttsEnabled = false; // Windows / Web ignored
    }
  }

  // 🔈 Safe speak helper
  Future<void> speak(String text) async {
    if (!ttsEnabled) return;
    await tts.speak(text);
  }

  // ▶️ Start workout
  Future<void> startWorkout() async {
    setState(() {
      isWorkingOut = true;
      currentSet = 1;
    });

    await speak("Get ready. Starting workout.");

    while (currentSet <= totalSets) {
      await speak("Set $currentSet");

      currentRep = 0;

      while (currentRep < totalReps) {
        await Future.delayed(const Duration(seconds: 1));

        currentRep++;

        int repsLeft = totalReps - currentRep;

        if (repsLeft == 2) {
          await speak("Three");
        } else if (repsLeft == 1) {
          await speak("Two");
        } else if (repsLeft == 0) {
          await speak("ONE! Finish strong!");
        } else {
          await speak(currentRep.toString());
        }

        setState(() {});
      }

      if (currentSet < totalSets) {
        await speak("Set complete. Rest.");

        for (int i = restSeconds; i > 0; i--) {
          await Future.delayed(const Duration(seconds: 1));
        }
      }

      currentSet++;
    }

    await speak("Workout complete. Great job!");

    setState(() {
      isWorkingOut = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: isWorkingOut
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Set $currentSet / $totalSets",
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "$currentRep / $totalReps",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: startWorkout,
                child: const Text("START"),
              ),
      ),
    );
  }
}
