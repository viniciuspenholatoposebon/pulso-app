import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import '../../data/datasources/training_split_datasource.dart';
import '../../data/models/training_goal.dart';
import '../../data/models/training_level.dart';
import '../../data/models/workout.dart';
import '../../data/models/workout_exercise.dart';
import '../../domain/services/training_builder_service.dart';
import '../../domain/services/training_generator_service.dart';

final workoutControllerProvider =
    AsyncNotifierProvider<WorkoutController, List<Workout>>(
  WorkoutController.new,
);

class WorkoutController extends AsyncNotifier<List<Workout>> {
  late final TrainingBuilderService _builder;

  @override
  Future<List<Workout>> build() async {
    _builder = const TrainingBuilderService(
      generator: TrainingGeneratorService(
        datasource: TrainingSplitDatasource(),
      ),
    );

    return loadWorkouts();
  }

  Future<List<Workout>> loadWorkouts() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return [];
    }

    final useCase = ref.read(
      getWorkoutsUseCaseProvider,
    );

    return useCase(
      user.uid,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      loadWorkouts,
    );
  }

  Future<void> generateWorkout({
    required TrainingGoal goal,
    required TrainingLevel level,
    required int trainingDays,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async {
        final user =
            FirebaseAuth.instance.currentUser;

        if (user == null) {
          throw Exception(
            'Usuário não autenticado.',
          );
        }

        final generated =
            _builder.build(
          goal: goal,
          level: level,
          trainingDays: trainingDays,
        );

        final workouts =
            generated.map(
          (item) {
            return Workout(
              id: DateTime.now()
                  .millisecondsSinceEpoch
                  .toString(),
              name: item.workoutName,
              description:
                  item.muscleGroup,
              weekDays: [
                item.weekDay,
              ],
              exercises: item.exercises
                  .asMap()
                  .entries
                  .map(
                    (exercise) =>
                        WorkoutExercise(
                      exerciseId:
                          exercise.value,
                      order:
                          exercise.key + 1,
                      sets: 4,
                      minReps: 8,
                      maxReps: 12,
                      restSeconds: 90,
                    ),
                  )
                  .toList(),
              estimatedDuration: 60,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
          },
        ).toList();

        final saveWorkout = ref.read(
          saveWorkoutUseCaseProvider,
        );

        for (final workout in workouts) {
          await saveWorkout(
            uid: user.uid,
            workout: workout,
          );
        }

        return loadWorkouts();
      },
    );
  }
}