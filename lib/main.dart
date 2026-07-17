import 'package:flutter/material.dart';
import 'package:meditation_now/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'providers/reminder_provider.dart';
import 'services/notification_service.dart';
import 'providers/session_provider.dart';
import 'screens/main_screen.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.initialize();

  await NotificationService
      .requestPermission();

  runApp(
      MultiProvider(
        providers: [

          ChangeNotifierProvider(
            create: (_) =>
                ReminderProvider(),
          ),

          ChangeNotifierProvider(
            create: (_) =>
                SessionProvider(),
          ),

          ChangeNotifierProvider(
            create: (_) =>
                ThemeProvider(),
          ),
        ],

        child:
        const MeditateNowApp(),
      ),
  );
}

class MeditateNowApp extends StatelessWidget {
  const MeditateNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'MeditateNow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: theme.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),
    );
  }
}