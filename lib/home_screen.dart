import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final bool isConnected;

  HomeScreen({required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Smart Yoga Mat')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/yoga_mat.png'), // Placeholder image
          Text(
            'Your Smart Yoga Companion',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/connect');
            },
            child: Text(isConnected ? 'Connected' : 'Connect to Mat'),
          ),
          const SizedBox(height: 20),
          // Control Panel Button
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/control');
            },
            child: const Text('Control Panel'),
          ),
          // Sound Options Button
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sound_options');
            },
            child: const Text('Music Sounds'),
          ),
          // Product Features
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/product_features');
            },
            child: const Text('Product & Features Showcase'),
          ),
          // OTA Update Screen
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/ota_update');
            },
            child: const Text('OTA Updates'),
          ),
          // Analytics Screen
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/analytics_screen');
            },
            child: const Text('Analytics Screen'),
          ),
        ],
      ),
    );
  }
}
