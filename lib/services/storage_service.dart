import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/reminder.dart';

class StorageService {

  static const String key =
      "meditation_reminders";

  static Future<void> saveReminders(
      List<Reminder> reminders) async {
    final prefs =
    await SharedPreferences.getInstance();

    final jsonList = reminders
        .map((r) => jsonEncode(r.toJson()))
        .toList();

    await prefs.setStringList(
      key,
      jsonList,
    );
  }

  static Future<List<Reminder>>
  loadReminders() async {
    final prefs =
    await SharedPreferences.getInstance();

    final jsonList =
    prefs.getStringList(key);

    if (jsonList == null) {
      return [];
    }

    return jsonList
        .map(
          (e) => Reminder.fromJson(
        jsonDecode(e),
      ),
    )
        .toList();
  }
}