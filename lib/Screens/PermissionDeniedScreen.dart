import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobitra/Screens/home.dart';

class PermissionDeniedScreen extends StatefulWidget {
  const PermissionDeniedScreen({super.key});

  @override
  State<PermissionDeniedScreen> createState() => _PermissionDeniedScreenState();
}

class _PermissionDeniedScreenState extends State<PermissionDeniedScreen> {
  String _statusMessage = 'Location permission is required to continue.';

  Future<void> _requestPermissionAgain() async {
    final foregroundStatus = await Permission.location.request();

    if (foregroundStatus.isGranted) {
      final backgroundStatus = await Permission.locationAlways.request();

      if (backgroundStatus.isGranted) {
        // Permission granted - navigate back to HomeScreen
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        setState(() {
          _statusMessage = '⚠️ Background location permission denied.';
        });
      }
    } else if (foregroundStatus.isDenied) {
      setState(() {
        _statusMessage = '❌ Foreground location permission denied.';
      });
    } else if (foregroundStatus.isPermanentlyDenied) {
      setState(() {
        _statusMessage =
            '❌ Permission permanently denied. Please enable it in app settings.';
      });
      // Optionally, open app settings directly:
      // await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permission Required')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off, size: 80, color: Colors.redAccent),
            const SizedBox(height: 20),
            Text(
              _statusMessage,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.location_searching),
              label: const Text('Grant Location Permission'),
              onPressed: _requestPermissionAgain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Please allow location access to use Mobitra services.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
