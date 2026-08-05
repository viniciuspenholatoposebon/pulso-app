import '../../domain/repositories/exercise_repository.dart';
import '../datasources/exercise_local_datasource.dart';
import '../models/exercise.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseLocalDatasource datasource;

  const ExerciseRepositoryImpl(
    this.datasource,
  );

  @override
  Future<List<Exercise>> getAllExercises() {
    return datasource.getAllExercises();
  }

  @override
  Future<List<Exercise>> searchExercises(
    String query,
  ) {
    return datasource.searchExercises(query);
  }

  @override
  Future<List<Exercise>> getExercisesByMuscle(
    String muscle,
  ) {
    return datasource.getExercisesByMuscle(muscle);
  }

  @override
  Future<List<Exercise>> getFavoriteExercises() {
    return datasource.getFavoriteExercises();
  }
}