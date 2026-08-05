import '../../data/datasources/training_split_datasource.dart';
import '../../data/models/training_goal.dart';
import '../../data/models/training_level.dart';
import '../../data/models/training_split.dart';

class TrainingGeneratorService {
  final TrainingSplitDatasource datasource;

  const TrainingGeneratorService({
    required this.datasource,
  });

  TrainingSplit generate({
    required TrainingGoal goal,
    required TrainingLevel level,
    required int trainingDays,
  }) {
    final splits = datasource.getSplits();

    return splits.firstWhere(
      (split) => split.trainingDays == trainingDays,
      orElse: () => splits.first,
    );
  }

  List<String> generateExercises({
    required String muscleGroup,
    required TrainingGoal goal,
    required TrainingLevel level,
  }) {
    switch (muscleGroup) {
      case 'Peito':
        return _chest(goal, level);

      case 'Costas':
        return _back(goal, level);

      case 'Pernas':
        return _legs(goal, level);

      case 'Ombros':
        return _shoulders(goal, level);

      case 'Braços':
        return _arms(goal, level);

      case 'Peito + Tríceps':
        return [
          ..._chest(goal, level),
          ..._triceps(goal, level),
        ];

      case 'Costas + Bíceps':
        return [
          ..._back(goal, level),
          ..._biceps(goal, level),
        ];

      case 'Pernas + Ombros':
        return [
          ..._legs(goal, level),
          ..._shoulders(goal, level),
        ];

      case 'Ombros + Braços':
        return [
          ..._shoulders(goal, level),
          ..._arms(goal, level),
        ];

      case 'Posterior + Abdômen':
        return [
          'Stiff',
          'Mesa Flexora',
          'Flexora Unilateral',
          'Elevação Pélvica',
          'Abdominal Máquina',
          'Prancha',
        ];

      default:
        return [
          'Exercício 1',
          'Exercício 2',
          'Exercício 3',
        ];
    }
  }

  List<String> _chest(
    TrainingGoal goal,
    TrainingLevel level,
  ) {
    return [
      'Supino Reto',
      'Supino Inclinado',
      'Crucifixo',
      'Crossover',
    ];
  }

  List<String> _back(
    TrainingGoal goal,
    TrainingLevel level,
  ) {
    return [
      'Puxada Frontal',
      'Remada Baixa',
      'Remada Curvada',
      'Pulldown',
    ];
  }

  List<String> _legs(
    TrainingGoal goal,
    TrainingLevel level,
  ) {
    return [
      'Agachamento Livre',
      'Leg Press',
      'Cadeira Extensora',
      'Mesa Flexora',
      'Panturrilha',
    ];
  }

  List<String> _shoulders(
    TrainingGoal goal,
    TrainingLevel level,
  ) {
    return [
      'Desenvolvimento',
      'Elevação Lateral',
      'Elevação Frontal',
      'Crucifixo Invertido',
    ];
  }

  List<String> _biceps(
    TrainingGoal goal,
    TrainingLevel level,
  ) {
    return [
      'Rosca Direta',
      'Rosca Alternada',
      'Rosca Scott',
    ];
  }

  List<String> _triceps(
    TrainingGoal goal,
    TrainingLevel level,
  ) {
    return [
      'Tríceps Pulley',
      'Tríceps Francês',
      'Tríceps Testa',
    ];
  }

  List<String> _arms(
    TrainingGoal goal,
    TrainingLevel level,
  ) {
    return [
      ..._biceps(goal, level),
      ..._triceps(goal, level),
    ];
  }
}