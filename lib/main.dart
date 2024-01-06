import 'package:flutter/material.dart';
import 'package:mausam/mausam_screen.dart';

void main() {
  runApp(const Mausam());
}

class Mausam extends StatelessWidget {
  const Mausam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const MausamScreen(),
    );
  }
}
