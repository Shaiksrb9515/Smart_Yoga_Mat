import 'package:flutter/material.dart';

class OTAUpdateScreen extends StatefulWidget {
  const OTAUpdateScreen({Key? key}) : super(key: key);

  @override
  State<OTAUpdateScreen> createState() => _OTAUpdateScreenState();
}

class _OTAUpdateScreenState extends State<OTAUpdateScreen> {
  String currentVersion = "1.0.0"; // Current version of the mat
  String latestVersion = "1.0.0"; // Will be updated after checking
  bool isChecking = false; // To manage loading state
  bool isUpdating = false; // To manage update process

  // Simulate a server check for the latest version
  Future<void> checkForUpdates() async {
    setState(() {
      isChecking = true;
    });

    // Simulated delay for checking updates
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      latestVersion = "1.1.0"; // Assume this is the latest version
      isChecking = false;
    });
  }

  // Simulate firmware update
  Future<void> performUpdate() async {
    setState(() {
      isUpdating = true;
    });

    // Simulated delay for update
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      currentVersion = latestVersion; // Update the version
      isUpdating = false;
    });

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Firmware updated successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTA Updates"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Over-the-Air (OTA) Updates",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Current Version: $currentVersion",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            if (!isChecking)
              Text(
                "Latest Version: $latestVersion",
                style: const TextStyle(fontSize: 18),
              )
            else
              const CircularProgressIndicator(), // Show loading while checking
            const SizedBox(height: 30),
            if (isUpdating)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (currentVersion == latestVersion)
              const Text(
                "Your firmware is up to date!",
                style: TextStyle(fontSize: 16, color: Colors.green),
              )
            else
              ElevatedButton(
                onPressed: performUpdate,
                child: const Text("Update Now"),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isChecking ? null : checkForUpdates,
              child: const Text("Check for Updates"),
            ),
          ],
        ),
      ),
    );
  }
}
