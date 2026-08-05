import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import '../../data/models/exercise_execution.dart';
import '../../data/models/workout.dart';
import '../../data/models/workout_session.dart';
import '../../data/models/workout_set.dart';
import '../../domain/usecases/get_all_exercises_usecase.dart';


final workoutExecutionControllerProvider =
    StateNotifierProvider<
        WorkoutExecutionController,
        WorkoutSession?>(
  (ref) {
    return WorkoutExecutionController(
      saveWorkoutSession:
          ref.read(
        saveWorkoutSessionUseCaseProvider,
      ),
      getAllExercises:
          ref.read(
        getAllExercisesUseCaseProvider,
      ),
    );
  },
);



class WorkoutExecutionController
    extends StateNotifier<WorkoutSession?> {

  WorkoutExecutionController({
    required this.saveWorkoutSession,
    required this.getAllExercises,
  }) : super(null);


  final dynamic saveWorkoutSession;

  final GetAllExercisesUseCase getAllExercises;



  Future<void> startWorkout(
    Workout workout,
  ) async {

    final exercisesCatalog =
        await getAllExercises();



    final exercises =
        workout.exercises.map(
      (
        exercise,
      ) {

        final catalogExercise =
            exercisesCatalog.firstWhere(
          (
            item,
          ) =>
              item.id ==
              exercise.exerciseId,

          orElse: () =>
              throw Exception(
            'Exercício não encontrado: ${exercise.exerciseId}',
          ),
        );


        return ExerciseExecution(

          exerciseId:
              exercise.exerciseId,

          exerciseName:
              catalogExercise.name,

          restSeconds:
              exercise.restSeconds,

          sets:
              List.generate(
            exercise.sets,
            (
              index,
            ) {

              return WorkoutSet(
                order:
                    index + 1,

                weight:
                    0,

                reps:
                    exercise.minReps,
              );
            },
          ),
        );
      },
    ).toList();



    state =
        WorkoutSession(

      id:
          DateTime.now()
              .millisecondsSinceEpoch
              .toString(),

      workoutId:
          workout.id,

      workoutName:
          workout.name,

      startedAt:
          DateTime.now(),

      exercises:
          exercises,
    );
  }





  void completeSet({
    required int exerciseIndex,
    required int setIndex,
    required double weight,
    required int reps,
  }) {

    if (state == null) {
      return;
    }


    final exercises =
        List<ExerciseExecution>.from(
      state!.exercises,
    );


    final exercise =
        exercises[exerciseIndex];


    final sets =
        List<WorkoutSet>.from(
      exercise.sets,
    );


    sets[setIndex] =
        sets[setIndex].copyWith(
      weight:
          weight,

      reps:
          reps,

      completed:
          true,

      completedAt:
          DateTime.now(),
    );


    exercises[exerciseIndex] =
        exercise.copyWith(
      sets:
          sets,
    );


    state =
        state!.copyWith(
      exercises:
          exercises,
    );
  }





  int getRestTime(
    int exerciseIndex,
  ) {

    if (state == null) {
      return 0;
    }


    if (exerciseIndex < 0 ||
        exerciseIndex >=
            state!.exercises.length) {
      return 0;
    }


    return state!
        .exercises[exerciseIndex]
        .restSeconds;
  }





  Future<void> finishWorkout() async {

    if (state == null) {
      return;
    }


    final finishedSession =
        state!.copyWith(

      completed:
          true,

      finishedAt:
          DateTime.now(),

      durationMinutes:
          DateTime.now()
              .difference(
                state!.startedAt,
              )
              .inMinutes,
    );


    state =
        finishedSession;


    final user =
        FirebaseAuth.instance.currentUser;


    if (user == null) {
      throw Exception(
        'Usuário não autenticado.',
      );
    }


    await saveWorkoutSession(
      uid:
          user.uid,

      session:
          finishedSession,
    );
  }





  void cancelWorkout() {
    state = null;
  }
}