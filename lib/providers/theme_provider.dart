import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs =
    await SharedPreferences.getInstance();

    _darkMode =
        prefs.getBool('dark_mode') ??
            false;

    notifyListeners();
  }

  Future<void> toggleTheme(
      bool value) async {
    _darkMode = value;

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setBool(
      'dark_mode',
      value,
    );

    notifyListeners();
  }
}