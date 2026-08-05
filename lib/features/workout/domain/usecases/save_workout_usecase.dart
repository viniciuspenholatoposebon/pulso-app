import '../repositories/workout_repository.dart';
import '../../data/models/workout.dart';

class SaveWorkoutUseCase {
  final WorkoutRepository repository;

  const SaveWorkoutUseCase({
    required this.repository,
  });

  Future<void> call({
    required String uid,
    required Workout workout,
  }) {
    return repository.saveWorkout(
      uid: uid,
      workout: workout,
    );
  }
}