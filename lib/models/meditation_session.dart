class MeditationSession {
  final DateTime date;

  MeditationSession({
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'date':
      date.toIso8601String(),
    };
  }

  factory MeditationSession
      .fromJson(
      Map<String, dynamic>
      json) {
    return MeditationSession(
      date: DateTime.parse(
        json['date'],
      ),
    );
  }
}