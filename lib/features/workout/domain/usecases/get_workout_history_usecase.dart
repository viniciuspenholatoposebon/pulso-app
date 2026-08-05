import '../../data/models/workout_session.dart';
import '../repositories/workout_repository.dart';

class GetWorkoutHistoryUseCase {
  final WorkoutRepository repository;

  const GetWorkoutHistoryUseCase({
    required this.repository,
  });

  Future<List<WorkoutSession>> call(
    String uid,
  ) {
    return repository.getWorkoutHistory(uid);
  }
}