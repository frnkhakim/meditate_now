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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'enabled': enabled,
    };
  }

  factory Reminder.fromJson(
      Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      time: json['time'],
      enabled: json['enabled'],
    );
  }
}