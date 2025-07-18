import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobitra/Screens/PermissionDeniedScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _locationStatus = 'Requesting permission...';

  @override
  void initState() {
    super.initState();
    _askLocationPermissions();
  }

  Future<void> _askLocationPermissions() async {
    final foreground = await Permission.location.request();

    if (foreground.isGranted) {
      final background = await Permission.locationAlways.request();
      if (background.isGranted) {
        setState(() {
          _locationStatus = '✅ Location permission granted (always)';
        });
      } else {
        setState(() {
          _locationStatus = '⚠️ Background location denied';
        });
        _navigateToDeniedScreen();
      }
    } else {
      setState(() {
        _locationStatus = '❌ Foreground location denied';
      });
      _navigateToDeniedScreen();
    }
  }

  void _navigateToDeniedScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const PermissionDeniedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobitra')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            _locationStatus,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
