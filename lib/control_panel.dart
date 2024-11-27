import 'package:flutter/material.dart';

class ControlPanelScreen extends StatefulWidget {
  const ControlPanelScreen({Key? key}) : super(key: key);

  @override
  State<ControlPanelScreen> createState() => _ControlPanelScreenState();
}

class _ControlPanelScreenState extends State<ControlPanelScreen> {
  String statusMessage = "Select a mode to start.";

  void _startWarmUp() {
    setState(() {
      statusMessage = "Warm-Up Mode Activated!";
    });

    // Simulate sending a command to the yoga mat
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        statusMessage = "Warm-Up Mode is running.";
      });
    });
  }

  void _startRelaxation() {
    setState(() {
      statusMessage = "Relaxation Mode Activated!";
    });

    // Simulate sending a command to the yoga mat
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        statusMessage = "Relaxation Mode is running.";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Control Your Smart Yoga Mat",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _startWarmUp,
              icon: const Icon(Icons.fitness_center),
              label: const Text("Start Warm-Up"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _startRelaxation,
              icon: const Icon(Icons.spa),
              label: const Text("Begin Relaxation Mode"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                statusMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
