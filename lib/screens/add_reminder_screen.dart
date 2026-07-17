import 'package:flutter/material.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() =>
      _AddReminderScreenState();
}

class _AddReminderScreenState
    extends State<AddReminderScreen> {

  final TextEditingController titleController =
  TextEditingController();

  TimeOfDay selectedTime =
  const TimeOfDay(hour: 7, minute: 0);

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

    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("Please enter a title"),
        ),
      );
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Reminder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Icon(
              Icons.self_improvement,
              size: 90,
            ),

            const SizedBox(height: 20),

            Text(
              "Create your meditation routine",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
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
                borderRadius:
                BorderRadius.circular(12),
              ),
              tileColor:
              Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
              title: const Text(
                  "Meditation Time"),
              subtitle: Text(
                selectedTime.format(context),
              ),
              trailing:
              const Icon(Icons.access_time),
              onTap: pickTime,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: saveReminder,
                icon: const Icon(Icons.save),
                label: const Text(
                    "Save Reminder"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}