import 'package:flutter/material.dart';
import '../widgets/reminder_card.dart';
import 'add_reminder_screen.dart';
import 'package:provider/provider.dart';
import '../models/reminder.dart';
import '../providers/reminder_provider.dart';
import '../providers/session_provider.dart';
import 'statistics_screen.dart';
import '../widgets/dashboard_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
    Provider.of<ReminderProvider>(context);

    final reminders = provider.reminders;

    final sessions =
    context.watch<
        SessionProvider>();

    final streak =
        sessions.streak;

    final activeReminders =
        reminders
            .where(
              (r) => r.enabled,
        )
            .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meditation Now"),
        actions: [

          IconButton(
            icon:
            const Icon(
              Icons.bar_chart,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const StatisticsScreen(),
                ),
              );
            },
          ),
        ],
      ),



      body: reminders.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [

            Icon(
              Icons.spa,
              size: 120,
              color: Colors.purple.shade300,
            ),

            const SizedBox(
                height: 20),

            const Text(
              "Begin Your Journey",
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 10),

            const Text(
              "Create your first meditation reminder.",
            ),
          ],
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

          Padding(
            padding:
            const EdgeInsets.all(16),
            child: SizedBox(
              width:
              double.infinity,
              child:
              FilledButton.icon(
                onPressed: () {

                  context
                      .read<
                      SessionProvider>()
                      .addSession();

                },
                icon: const Icon(
                    Icons.spa),
                label: const Text(
                  "Complete Meditation",
                ),
              ),
            ),
          ),

          SizedBox(
            height: 180,
            child: GridView.count(
              crossAxisCount: 2,
              physics:
              const NeverScrollableScrollPhysics(),
              children: [

                DashboardCard(
                  icon:
                  Icons.local_fire_department,
                  title: "Streak",
                  value:
                  "$streak",
                ),

                DashboardCard(
                  icon:
                  Icons.alarm,
                  title:
                  "Active",
                  value:
                  "$activeReminders",
                ),
              ],
            ),
          ),

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
                        reminder: reminders[index],
                        onTap: () async {
                          final updated =
                          await Navigator.push<Reminder>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddReminderScreen(
                                reminder: reminders[index],
                              ),
                            ),
                          );
                          if (updated != null) {
                            provider.updateReminder(updated);
                          }
                        },
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
