import '../../data/models/exercise.dart';
import '../repositories/exercise_repository.dart';

class GetAllExercisesUseCase {
  final ExerciseRepository repository;

  const GetAllExercisesUseCase({
    required this.repository,
  });

  Future<List<Exercise>> call() {
    return repository.getAllExercises();
  }

  Future<List<Exercise>> search(
    String query,
  ) {
    return repository.searchExercises(query);
  }

  Future<List<Exercise>> byMuscle(
    String muscle,
  ) {
    return repository.getExercisesByMuscle(
      muscle,
    );
  }

  Future<List<Exercise>> favorites() {
    return repository.getFavoriteExercises();
  }
}