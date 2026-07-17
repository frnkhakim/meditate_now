import 'package:flutter/material.dart';
import 'package:meditation_now/screens/home_screen.dart';
import 'package:meditation_now/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'providers/reminder_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ReminderProvider(),
      child: const MeditateNowApp(),
    ),
  );
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