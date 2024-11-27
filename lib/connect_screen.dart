import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  bool isScanning = false;
  BluetoothDevice? connectedDevice;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted &&
        await Permission.location.request().isGranted) {
      // Permissions granted
    } else {
      // Handle permission denial
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permissions Required'),
          content: const Text(
              'Bluetooth and Location permissions are required to scan and connect to devices.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _startScan() {
    setState(() {
      isScanning = true;
    });

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5)).then((_) {
      setState(() {
        isScanning = false;
      });
    }).catchError((error) {
      setState(() {
        isScanning = false;
      });
      // Handle scanning error
      print("Scan Error: $error");
    });
  }

  void _connectToDevice(BluetoothDevice device) async {
    try {
      // Show confirmation dialog
      bool? shouldConnect = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Connect to Device'),
          content: Text('Do you want to connect to ${device.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Connect'),
            ),
          ],
        ),
      );

      if (shouldConnect == true) {
        // Attempt to connect
        await device.connect();
        setState(() {
          connectedDevice = device;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connected to ${device.name}')),
        );
      }
    } catch (e) {
      print('Connection Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect to ${device.name}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connect to Mat')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _startScan,
            child: Text(isScanning ? 'Scanning...' : 'Scan for Devices'),
          ),
          Expanded(
            child: StreamBuilder<List<ScanResult>>(
              stream: FlutterBluePlus.scanResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final results = snapshot.data!;
                  return ListView(
                    children: results.map((result) {
                      return ListTile(
                        title: Text(result.device.name.isNotEmpty
                            ? result.device.name
                            : 'Unknown Device'),
                        subtitle: Text(result.device.remoteId.toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.bluetooth),
                          onPressed: () => _connectToDevice(result.device),
                        ),
                      );
                    }).toList(),
                  );
                }
                return const Center(child: Text('No devices found.'));
              },
            ),
          ),
          if (connectedDevice != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Connected to: ${connectedDevice!.name}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
