import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/exercise.dart';
import '../../domain/usecases/get_all_exercises_usecase.dart';
import '../../../../providers/repository_providers.dart';

final exerciseControllerProvider =
    AsyncNotifierProvider<ExerciseController, List<Exercise>>(
  ExerciseController.new,
);

class ExerciseController extends AsyncNotifier<List<Exercise>> {
  late final GetAllExercisesUseCase _useCase;

  @override
  Future<List<Exercise>> build() async {
    _useCase = ref.read(
      getAllExercisesUseCaseProvider,
    );

    return _useCase();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => _useCase(),
    );
  }

  Future<void> search(
    String query,
  ) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => _useCase.search(query),
    );
  }

  Future<void> filterByMuscle(
    String muscle,
  ) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => _useCase.byMuscle(muscle),
    );
  }

  Future<void> showFavorites() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => _useCase.favorites(),
    );
  }

  Future<void> clearFilters() async {
    await refresh();
  }
}