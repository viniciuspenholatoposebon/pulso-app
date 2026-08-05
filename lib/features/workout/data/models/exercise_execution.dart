import 'workout_set.dart';

class ExerciseExecution {
  final String exerciseId;

  final String exerciseName;

  final List<WorkoutSet> sets;

  final String? notes;

  final int restSeconds;

  const ExerciseExecution({
    required this.exerciseId,
    required this.exerciseName,
    required this.sets,
    this.notes,
    this.restSeconds = 90,
  });

  ExerciseExecution copyWith({
    String? exerciseId,
    String? exerciseName,
    List<WorkoutSet>? sets,
    String? notes,
    int? restSeconds,
  }) {
    return ExerciseExecution(
      exerciseId:
          exerciseId ?? this.exerciseId,
      exerciseName:
          exerciseName ?? this.exerciseName,
      sets:
          sets ?? this.sets,
      notes:
          notes ?? this.notes,
      restSeconds:
          restSeconds ?? this.restSeconds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'exerciseName': exerciseName,
      'sets': sets
          .map(
            (e) => e.toMap(),
          )
          .toList(),
      'notes': notes,
      'restSeconds': restSeconds,
    };
  }

  factory ExerciseExecution.fromMap(
    Map<String, dynamic> map,
  ) {
    return ExerciseExecution(
      exerciseId:
          map['exerciseId'],
      exerciseName:
          map['exerciseName'],
      sets:
          (map['sets'] as List)
              .map(
                (e) => WorkoutSet.fromMap(
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList(),
      notes:
          map['notes'],
      restSeconds:
          map['restSeconds'] ?? 90,
    );
  }
}