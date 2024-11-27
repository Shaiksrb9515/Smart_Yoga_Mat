import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  final int totalYogaSessions = 42; // Replace with real data
  final String mostUsedFunction = "Relaxation Mode"; // Replace with real data
  final Map<String, int> functionUsageStats = {
    "Warm-Up Mode": 18,
    "Relaxation Mode": 24,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics Overview"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Yoga Mat Analytics",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(
                  Icons.timer,
                  color: Colors.blue,
                  size: 40,
                ),
                title: const Text("Total Yoga Sessions"),
                subtitle: Text(
                  "$totalYogaSessions sessions",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.green,
                  size: 40,
                ),
                title: const Text("Most-Used Function"),
                subtitle: Text(
                  mostUsedFunction,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Function Usage Stats",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: functionUsageStats.keys.length,
                itemBuilder: (context, index) {
                  String functionName = functionUsageStats.keys.elementAt(index);
                  int usageCount = functionUsageStats[functionName]!;
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(
                        Icons.bar_chart,
                        color: Colors.purple,
                      ),
                      title: Text(functionName),
                      trailing: Text(
                        "$usageCount times",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
