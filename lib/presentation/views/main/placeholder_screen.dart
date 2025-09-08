import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF007FFF),
      ),
      body: Center(
        child: Text(
          'Halaman $title',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}