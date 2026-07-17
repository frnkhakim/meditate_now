class Reminder {
  final String id;
  final String title;
  final String time;
  bool enabled;

  Reminder({
    required this.id,
    required this.title,
    required this.time,
    this.enabled = true,
  });
}