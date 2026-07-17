import 'package:flutter/material.dart';
import '../models/reminder.dart';
import '../widgets/reminder_card.dart';
import 'add_reminder_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reminders = [
      Reminder(
        id: "1",
        title: "Morning Meditation",
        time: "07:00 AM",
      ),
      Reminder(
        id: "2",
        title: "Lunch Break Meditation",
        time: "01:00 PM",
      ),
      Reminder(
        id: "3",
        title: "Sleep Meditation",
        time: "09:00 PM",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("MeditateNow"),
      ),
      body: reminders.isEmpty
          ? const Center(
              child: Text(
                "No reminders yet",
              ),
            )
          : Column(
              children: [
                const SizedBox(height: 20),
                const Icon(
                  Icons.spa,
                  size: 80,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Find Your Inner Peace",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: reminders.length,
                    itemBuilder: (context, index) {
                      return ReminderCard(
                        reminder: reminders[index],
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton:
      FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AddReminderScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
