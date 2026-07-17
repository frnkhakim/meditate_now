import 'package:flutter/material.dart';
import '../models/reminder.dart';

class AddReminderScreen extends StatefulWidget {
  final Reminder? reminder;

  const AddReminderScreen({super.key, this.reminder});

  @override
  State<AddReminderScreen> createState() =>
      _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  late final TextEditingController titleController;
  late TimeOfDay selectedTime;

  bool get isEditing => widget.reminder != null;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.reminder?.title ?? '',
    );
    if (widget.reminder != null) {
      final parts = widget.reminder!.time.split(':');
      final hour = int.tryParse(parts[0]) ?? 7;
      final minutePart = parts.length > 1 ? parts[1].replaceAll(RegExp(r'[^0-9]'), '') : '0';
      final minute = int.tryParse(minutePart) ?? 0;
      final isPm = widget.reminder!.time.toLowerCase().contains('pm');
      selectedTime = TimeOfDay(
        hour: isPm && hour != 12 ? hour + 12 : (!isPm && hour == 12 ? 0 : hour),
        minute: minute,
      );
    } else {
      selectedTime = const TimeOfDay(hour: 7, minute: 0);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void saveReminder() {
    if (titleController.text.isEmpty) return;

    final reminder = Reminder(
      id: widget.reminder?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      time: selectedTime.format(context),
      enabled: widget.reminder?.enabled ?? true,
    );

    Navigator.pop(context, reminder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Reminder" : "Add Reminder"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.self_improvement, size: 90),
            const SizedBox(height: 20),
            Text(
              isEditing
                  ? "Update your meditation reminder"
                  : "Create your meditation routine",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Reminder Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
              title: const Text("Meditation Time"),
              subtitle: Text(selectedTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: pickTime,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: saveReminder,
                icon: Icon(isEditing ? Icons.check : Icons.save),
                label: Text(isEditing ? "Update Reminder" : "Save Reminder"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
