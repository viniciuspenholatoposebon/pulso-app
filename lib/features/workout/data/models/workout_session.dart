import 'exercise_execution.dart';

class WorkoutSession {
  final String id;

  final String workoutId;

  final String workoutName;

  final DateTime startedAt;

  final DateTime? finishedAt;

  final List<ExerciseExecution> exercises;

  final int durationMinutes;

  final bool completed;

  const WorkoutSession({
    required this.id,
    required this.workoutId,
    required this.workoutName,
    required this.startedAt,
    required this.exercises,
    this.finishedAt,
    this.durationMinutes = 0,
    this.completed = false,
  });


  int get totalSets {
    return exercises.fold(
      0,
      (
        total,
        exercise,
      ) {
        return total + exercise.sets.length;
      },
    );
  }


  int get completedSets {
    return exercises.fold(
      0,
      (
        total,
        exercise,
      ) {
        return total +
            exercise.sets
                .where(
                  (set) => set.completed,
                )
                .length;
      },
    );
  }


  double get totalVolume {
    return exercises.fold(
      0,
      (
        total,
        exercise,
      ) {
        return total +
            exercise.sets.fold(
              0,
              (
                setTotal,
                set,
              ) {
                return setTotal +
                    (set.weight * set.reps);
              },
            );
      },
    );
  }



  WorkoutSession copyWith({
    String? id,
    String? workoutId,
    String? workoutName,
    DateTime? startedAt,
    DateTime? finishedAt,
    List<ExerciseExecution>? exercises,
    int? durationMinutes,
    bool? completed,
  }) {
    return WorkoutSession(
      id:
          id ?? this.id,

      workoutId:
          workoutId ?? this.workoutId,

      workoutName:
          workoutName ?? this.workoutName,

      startedAt:
          startedAt ?? this.startedAt,

      finishedAt:
          finishedAt ?? this.finishedAt,

      exercises:
          exercises ?? this.exercises,

      durationMinutes:
          durationMinutes ?? this.durationMinutes,

      completed:
          completed ?? this.completed,
    );
  }



  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'workoutId':
          workoutId,

      'workoutName':
          workoutName,

      'startedAt':
          startedAt.millisecondsSinceEpoch,

      'finishedAt':
          finishedAt?.millisecondsSinceEpoch,

      'durationMinutes':
          durationMinutes,

      'completed':
          completed,

      'exercises':
          exercises
              .map(
                (e) => e.toMap(),
              )
              .toList(),
    };
  }



  factory WorkoutSession.fromMap(
    Map<String, dynamic> map,
  ) {
    return WorkoutSession(
      id:
          map['id'],

      workoutId:
          map['workoutId'],

      workoutName:
          map['workoutName'] ?? 'Treino',

      startedAt:
          DateTime.fromMillisecondsSinceEpoch(
        map['startedAt'],
      ),

      finishedAt:
          map['finishedAt'] == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(
                  map['finishedAt'],
                ),

      durationMinutes:
          map['durationMinutes'] ?? 0,

      completed:
          map['completed'] ?? false,

      exercises:
          (map['exercises'] as List)
              .map(
                (e) =>
                    ExerciseExecution.fromMap(
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList(),
    );
  }
}