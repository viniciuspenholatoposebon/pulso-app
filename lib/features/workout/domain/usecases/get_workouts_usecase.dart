import '../../data/models/workout.dart';
import '../repositories/workout_repository.dart';

class GetWorkoutsUseCase {
  final WorkoutRepository repository;

  const GetWorkoutsUseCase({
    required this.repository,
  });

  Future<List<Workout>> call(
    String uid,
  ) {
    return repository.getWorkouts(uid);
  }
}