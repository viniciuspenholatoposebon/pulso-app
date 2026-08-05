import '../../data/models/workout_session.dart';
import '../repositories/workout_repository.dart';

class SaveWorkoutSessionUseCase {
  final WorkoutRepository repository;

  const SaveWorkoutSessionUseCase({
    required this.repository,
  });

  Future<void> call({
    required String uid,
    required WorkoutSession session,
  }) {
    return repository.saveWorkoutSession(
      uid: uid,
      session: session,
    );
  }
}