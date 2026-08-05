import 'exercise_set_execution.dart';

class WorkoutExerciseExecution {
  /// ID do exercício.
  final String exerciseId;

  /// Ordem dentro do treino.
  final int order;

  /// Séries executadas.
  final List<ExerciseSetExecution> sets;

  /// Volume total (kg).
  final double totalVolume;

  /// Tempo gasto neste exercício.
  final int durationSeconds;

  /// Exercício concluído?
  final bool completed;

  const WorkoutExerciseExecution({
    required this.exerciseId,
    required this.order,
    required this.sets,
    required this.totalVolume,
    required this.durationSeconds,
    this.completed = false,
  });

  WorkoutExerciseExecution copyWith({
    String? exerciseId,
    int? order,
    List<ExerciseSetExecution>? sets,
    double? totalVolume,
    int? durationSeconds,
    bool? completed,
  }) {
    return WorkoutExerciseExecution(
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
      sets: sets ?? this.sets,
      totalVolume: totalVolume ?? this.totalVolume,
      durationSeconds:
          durationSeconds ?? this.durationSeconds,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'order': order,
      'sets': sets.map((e) => e.toMap()).toList(),
      'totalVolume': totalVolume,
      'durationSeconds': durationSeconds,
      'completed': completed,
    };
  }

  factory WorkoutExerciseExecution.fromMap(
    Map<String, dynamic> map,
  ) {
    return WorkoutExerciseExecution(
      exerciseId: map['exerciseId'],
      order: map['order'],
      sets: (map['sets'] as List<dynamic>? ?? [])
          .map(
            (e) => ExerciseSetExecution.fromMap(
              Map<String, dynamic>.from(e),
            ),
          )
          .toList(),
      totalVolume:
          (map['totalVolume'] as num).toDouble(),
      durationSeconds: map['durationSeconds'],
      completed: map['completed'] ?? false,
    );
  }
}