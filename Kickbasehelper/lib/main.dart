import 'package:flutter/material.dart';

void main() {
  runApp(const KickbasehelperApp());
}

class KickbasehelperApp extends StatelessWidget {
  const KickbasehelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kickbasehelper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kickbasehelper'),
      ),
      body: const Center(
        child: Text('Welcome to Kickbasehelper!'),
      ),
    );
  }
}