import 'package:flutter/material.dart';
import '../widgets/reminder_card.dart';
import 'add_reminder_screen.dart';
import 'package:provider/provider.dart';
import '../models/reminder.dart';
import '../providers/reminder_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
    Provider.of<ReminderProvider>(context);

    final reminders = provider.reminders;

    return Scaffold(
      appBar: AppBar(
        title: const Text("MeditateNow"),
      ),


      body: reminders.isEmpty
          ? const Center(
        child: Text(
          "No meditation reminders yet 🧘",
          style: TextStyle(fontSize: 20),
        ),
      )
          : Column(
        children: [
          const SizedBox(height: 20),

          const Icon(
            Icons.spa,
            size: 80,
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: reminders.length,
              itemBuilder:
                  (context, index) {
                    return Dismissible(
                      key: ValueKey(
                          reminders[index].id),
                      direction:
                      DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment:
                        Alignment.centerRight,
                        padding:
                        const EdgeInsets.only(
                            right: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      confirmDismiss: (_) async {
                        return await showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                title:
                                const Text(
                                  "Delete Reminder",
                                ),
                                content:
                                const Text(
                                  "Are you sure?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(
                                          context,
                                          false,
                                        ),
                                    child:
                                    const Text(
                                      "Cancel",
                                    ),
                                  ),
                                  FilledButton(
                                    onPressed: () =>
                                        Navigator.pop(
                                          context,
                                          true,
                                        ),
                                    child:
                                    const Text(
                                      "Delete",
                                    ),
                                  ),
                                ],
                              ),
                        );
                      },
                      onDismissed: (_) {
                        provider.removeReminder(
                          reminders[index].id,
                        );
                      },
                      child: ReminderCard(
                        reminder:
                        reminders[index],
                      ),
                    );
              },
            ),
          ),
        ],
      ),
      floatingActionButton:
      FloatingActionButton(
        onPressed: () async {

          final reminder =
          await Navigator.push<Reminder>(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AddReminderScreen(),
            ),
          );

          if (reminder != null) {
            provider.addReminder(reminder);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
