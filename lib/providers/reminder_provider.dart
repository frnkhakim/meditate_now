import 'package:flutter/material.dart';
import '../models/reminder.dart';
import '../services/storage_service.dart';

class ReminderProvider extends ChangeNotifier {
  final List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  ReminderProvider() {
    loadReminders();
  }

  Future<void> loadReminders() async {
    final data = await StorageService.loadReminders();
    _reminders.clear();
    _reminders.addAll(data);
    notifyListeners();
  }

  void addReminder(Reminder reminder) {
    _reminders.add(reminder);
    StorageService.saveReminders(_reminders);
    notifyListeners();
  }

  void removeReminder(String id) {
    _reminders.removeWhere((r) => r.id == id);
    StorageService.saveReminders(_reminders);
    notifyListeners();
  }

  void updateReminder(Reminder updated) {
    final index = _reminders.indexWhere((r) => r.id == updated.id);
    if (index != -1) {
      _reminders[index] = updated;
      StorageService.saveReminders(_reminders);
      notifyListeners();
    }
  }

  void toggleReminder(String id) {
    final reminder = _reminders.firstWhere((r) => r.id == id);
    reminder.enabled = !reminder.enabled;
    StorageService.saveReminders(_reminders);
    notifyListeners();
  }
}
