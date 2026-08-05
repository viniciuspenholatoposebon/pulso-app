import '../../data/models/generated_workout.dart';
import '../../data/models/training_goal.dart';
import '../../data/models/training_level.dart';
import 'training_generator_service.dart';

class TrainingBuilderService {
  final TrainingGeneratorService generator;

  const TrainingBuilderService({
    required this.generator,
  });

  List<GeneratedWorkout> build({
    required TrainingGoal goal,
    required TrainingLevel level,
    required int trainingDays,
  }) {
    final split = generator.generate(
      goal: goal,
      level: level,
      trainingDays: trainingDays,
    );

    final List<GeneratedWorkout> workouts = [];

    for (int i = 0; i < split.muscleGroups.length; i++) {
      final muscleGroup = split.muscleGroups[i];

      workouts.add(
        GeneratedWorkout(
          workoutName: 'Treino ${String.fromCharCode(65 + i)}',
          weekDay: split.weekDays[i],
          muscleGroup: muscleGroup,
          exercises: generator.generateExercises(
            muscleGroup: muscleGroup,
            goal: goal,
            level: level,
          ),
        ),
      );
    }

    return workouts;
  }
}