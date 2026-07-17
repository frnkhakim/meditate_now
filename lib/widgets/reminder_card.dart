import 'package:flutter/material.dart';
import '../models/reminder.dart';
import 'package:provider/provider.dart';
import '../providers/reminder_provider.dart';
import '../services/storage_service.dart';

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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration:
            reminder.enabled
                ? null
                : TextDecoration.lineThrough,
          ),
        ),
        subtitle: Text(
          reminder.enabled
              ? reminder.time
              : "Disabled",
        ),
        trailing: Switch(
          value: reminder.enabled,
          onChanged: (_) {
            context
                .read<ReminderProvider>()
                .toggleReminder(
              reminder.id,
            );
          },
        ),
      ),
    );
  }
}