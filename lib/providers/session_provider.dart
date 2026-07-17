import 'package:flutter/material.dart';

import '../models/meditation_session.dart';

class SessionProvider
    extends ChangeNotifier {

  final List<
      MeditationSession>
  _sessions = [];

  List<MeditationSession>
  get sessions =>
      _sessions;

  void addSession() {
    _sessions.add(
      MeditationSession(
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  int get streak {

    if (_sessions.isEmpty) {
      return 0;
    }

    final dates =
    _sessions
        .map(
          (e) => DateTime(
        e.date.year,
        e.date.month,
        e.date.day,
      ),
    )
        .toSet()
        .toList();

    dates.sort();

    int count = 1;

    for (
    int i = dates.length - 1;
    i > 0;
    i--) {

      final difference =
          dates[i]
              .difference(
              dates[i - 1])
              .inDays;

      if (difference == 1) {
        count++;
      } else {
        break;
      }
    }

    return count;
  }
}