import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobitra/Screens/permission_denied_screen.dart';
import 'package:mobitra/Screens/login_screen.dart';
import 'package:mobitra/bloc/permission_bloc.dart';
import 'package:mobitra/bloc/permission_event.dart';
import 'package:mobitra/bloc/permission_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PermissionBloc>().add(RequestPermissionEvent('location'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobitra')),
      body: BlocConsumer<PermissionBloc, PermissionState>(
        listener: (context, state) {
          if (state is PermissionGranted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          } else if (state is PermissionDeniedForeground ||
              state is PermissionDeniedBackground ||
              state is PermissionPermanentlyDenied) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const PermissionDeniedScreen()),
            );
          }
        },
        builder: (context, state) {
          if (state is PermissionError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
