import '../../data/models/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getAllExercises();

  Future<List<Exercise>> searchExercises(
    String query,
  );

  Future<List<Exercise>> getExercisesByMuscle(
    String muscle,
  );

  Future<List<Exercise>> getFavoriteExercises();
}