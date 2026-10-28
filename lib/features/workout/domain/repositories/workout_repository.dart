import '../../data/models/workout.dart';
import '../../data/models/workout_session.dart';

abstract class WorkoutRepository {

  Future<void> saveWorkout({
    required String uid,
    required Workout workout,
  });


  Future<List<Workout>> getWorkouts(
    String uid,
  );


  Future<void> deactivateOldWorkouts(
    String uid,
  );


  Future<void> deleteWorkout({
    required String uid,
    required String workoutId,
  });


  Future<void> saveWorkoutSession({
    required String uid,
    required WorkoutSession session,
  });


  Future<List<WorkoutSession>> getWorkoutHistory(
    String uid,
  );

}