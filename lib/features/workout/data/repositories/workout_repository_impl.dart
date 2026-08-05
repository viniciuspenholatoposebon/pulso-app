import '../../domain/repositories/workout_repository.dart';
import '../datasources/firestore_workout_datasource.dart';
import '../models/workout.dart';
import '../models/workout_session.dart';

class WorkoutRepositoryImpl
    implements WorkoutRepository {
  final FirestoreWorkoutDatasource datasource;

  const WorkoutRepositoryImpl(
    this.datasource,
  );

  @override
  Future<void> saveWorkout({
    required String uid,
    required Workout workout,
  }) {
    return datasource.saveWorkout(
      uid: uid,
      workout: workout,
    );
  }

  @override
  Future<List<Workout>> getWorkouts(
    String uid,
  ) {
    return datasource.getWorkouts(uid);
  }

  @override
  Future<void> deleteWorkout({
    required String uid,
    required String workoutId,
  }) {
    return datasource.deleteWorkout(
      uid: uid,
      workoutId: workoutId,
    );
  }

  @override
  Future<void> saveWorkoutSession({
    required String uid,
    required WorkoutSession session,
  }) {
    return datasource.saveWorkoutSession(
      uid: uid,
      session: session,
    );
  }

  @override
  Future<List<WorkoutSession>>
      getWorkoutHistory(
    String uid,
  ) {
    return datasource.getWorkoutHistory(
      uid,
    );
  }
}