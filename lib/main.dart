import 'package:flutter/material.dart';
import 'package:shartflix_movie_app_case/main_screen.dart';

void main() {
  runApp(const ShartflixApp());
}

class ShartflixApp extends StatelessWidget {
  const ShartflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}