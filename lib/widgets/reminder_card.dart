import 'package:flutter/material.dart';
import '../models/reminder.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;

  const ReminderCard({
    super.key,
    required this.reminder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.self_improvement),
        ),
        title: Text(
          reminder.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(reminder.time),
        trailing: Switch(
          value: reminder.enabled,
          onChanged: (_) {},
        ),
      ),
    );
  }
}