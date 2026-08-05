import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import '../../data/models/workout_session.dart';


final workoutHistoryControllerProvider =
    FutureProvider<List<WorkoutSession>>(
  (ref) async {

    final user =
        ref.read(
          authRepositoryProvider,
        ).currentUser;


    if (user == null) {
      return [];
    }


    final getHistory =
        ref.read(
          getWorkoutHistoryUseCaseProvider,
        );


    return getHistory(
      user.id,
    );
  },
);