import 'package:flutter/material.dart';
import 'package:meditation_now/screens/home_screen.dart';
import 'package:meditation_now/theme/app_theme.dart';

void main() {
  runApp(const MeditateNowApp());
}

class MeditateNowApp extends StatelessWidget {
  const MeditateNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeditateNow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}