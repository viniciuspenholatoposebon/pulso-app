import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import '../../../workout/data/models/workout_session.dart';

final workoutStatsControllerProvider =
    FutureProvider<WorkoutStats>((ref) async {
  final user =
      ref.read(authRepositoryProvider).currentUser;

  if (user == null) {
    return WorkoutStats.empty();
  }

  final history = await ref
      .read(
        getWorkoutHistoryUseCaseProvider,
      )
      .call(
        user.id,
      );

  return WorkoutStats.fromSessions(
    history,
  );
});


class WorkoutStats {
  final int totalWorkouts;
  final int currentStreak;
  final int bestStreak;
  final int totalMinutes;
  final List<WorkoutSession> recentWorkouts;

  const WorkoutStats({
    required this.totalWorkouts,
    required this.currentStreak,
    required this.bestStreak,
    required this.totalMinutes,
    required this.recentWorkouts,
  });


  factory WorkoutStats.empty() {
    return const WorkoutStats(
      totalWorkouts: 0,
      currentStreak: 0,
      bestStreak: 0,
      totalMinutes: 0,
      recentWorkouts: [],
    );
  }


  factory WorkoutStats.fromSessions(
    List<WorkoutSession> sessions,
  ) {
    if (sessions.isEmpty) {
      return WorkoutStats.empty();
    }

    final ordered =
        List<WorkoutSession>.from(
      sessions,
    )
          ..sort(
            (a, b) => b.startedAt.compareTo(
              a.startedAt,
            ),
          );


    final totalMinutes =
    ordered.fold<int>(
  0,
  (total, session) {
    return total +
        session.durationMinutes;
  },
);


    final streak =
        _calculateCurrentStreak(
      ordered,
    );


    return WorkoutStats(
      totalWorkouts: ordered.length,
      currentStreak: streak,
      bestStreak: streak,
      totalMinutes: totalMinutes,
      recentWorkouts:
          ordered.take(5).toList(),
    );
  }


  static int _calculateCurrentStreak(
    List<WorkoutSession> sessions,
  ) {
    if (sessions.isEmpty) {
      return 0;
    }

    int streak = 0;

    DateTime? lastDate;


    for (final session in sessions) {
      final date = DateTime(
        session.startedAt.year,
        session.startedAt.month,
        session.startedAt.day,
      );


      if (lastDate == null) {
        streak = 1;
        lastDate = date;
        continue;
      }


      final difference =
          lastDate.difference(date).inDays;


      if (difference == 1) {
        streak++;
        lastDate = date;
      } else if (difference == 0) {
        continue;
      } else {
        break;
      }
    }


    return streak;
  }
}