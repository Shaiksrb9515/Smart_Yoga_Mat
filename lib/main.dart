import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'connect_screen.dart';
import 'control_panel.dart';
import 'sound_options.dart';
import 'ota_update_screen.dart';
import 'showcase_screen.dart';
import 'analytics_screen.dart';

void main() {
  runApp(SmartYogaMatApp());
}

class SmartYogaMatApp extends StatelessWidget {
  const SmartYogaMatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: 'Smart Yoga Mat',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Customize the theme color
      ),
      // Initial route
      initialRoute: '/',
      // Define routes for navigation
      routes: {
        '/': (context) => HomeScreen(isConnected: false),
        '/connect': (context) =>  ConnectScreen(),
        '/control': (context) => const ControlPanelScreen(),
        '/sound_options': (context) =>  SoundScreen(),
        '/product_features': (context) => ProductFeatureScreen(),
        '/ota_update': (context) =>  OTAUpdateScreen(),
        '/analytics_screen': (context) => AnalyticsScreen(),
      },
    );
  }
}
