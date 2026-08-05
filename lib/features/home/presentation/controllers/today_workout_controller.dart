import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import '../../../workout/data/models/workout.dart';
import '../../../workout/data/models/workout_session.dart';


final todayWorkoutControllerProvider =
    FutureProvider<TodayWorkout>((ref) async {
  final user =
      ref.read(authRepositoryProvider).currentUser;

  if (user == null) {
    return TodayWorkout.restDay();
  }

  final workouts = await ref
      .read(
        getWorkoutsUseCaseProvider,
      )
      .call(
        user.id,
      );

  final history = await ref
      .read(
        getWorkoutHistoryUseCaseProvider,
      )
      .call(
        user.id,
      );

  return TodayWorkout.fromData(
    workouts,
    history,
  );
});


class TodayWorkout {
  final Workout? workout;
  final bool completedToday;

  const TodayWorkout({
    required this.workout,
    required this.completedToday,
  });


  factory TodayWorkout.restDay() {
    return const TodayWorkout(
      workout: null,
      completedToday: false,
    );
  }


  factory TodayWorkout.fromData(
    List<Workout> workouts,
    List<WorkoutSession> sessions,
  ) {
    final today =
        _weekdayName(DateTime.now().weekday);


    Workout? todayWorkout;


    for (final workout in workouts) {
      if (workout.weekDays.contains(today) &&
          workout.isActive) {
        todayWorkout = workout;
        break;
      }
    }


    final completed =
        sessions.any(
      (session) {
        final date =
            session.startedAt;

        final now =
            DateTime.now();

        return session.completed &&
            date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;
      },
    );


    return TodayWorkout(
      workout: todayWorkout,
      completedToday: completed,
    );
  }


  static String _weekdayName(
    int weekday,
  ) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';

      case DateTime.tuesday:
        return 'Tuesday';

      case DateTime.wednesday:
        return 'Wednesday';

      case DateTime.thursday:
        return 'Thursday';

      case DateTime.friday:
        return 'Friday';

      case DateTime.saturday:
        return 'Saturday';

      case DateTime.sunday:
        return 'Sunday';

      default:
        return '';
    }
  }
}