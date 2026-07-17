import 'package:flutter/material.dart';
import '../models/reminder.dart';

class ReminderProvider extends ChangeNotifier {
  final List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  void addReminder(Reminder reminder) {
    _reminders.add(reminder);
    notifyListeners();
  }

  void removeReminder(String id) {
    _reminders.removeWhere(
          (r) => r.id == id,
    );

    notifyListeners();
  }

  void toggleReminder(String id) {
    final reminder = _reminders.firstWhere(
          (r) => r.id == id,
    );

    reminder.enabled =
    !reminder.enabled;

    notifyListeners();
  }
}