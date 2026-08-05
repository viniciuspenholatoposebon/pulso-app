class TrainingExercise {
  final String exerciseId;

  final int sets;

  final int minReps;

  final int maxReps;

  final int restSeconds;

  final String notes;

  const TrainingExercise({
    required this.exerciseId,
    required this.sets,
    required this.minReps,
    required this.maxReps,
    required this.restSeconds,
    this.notes = '',
  });

  TrainingExercise copyWith({
    String? exerciseId,
    int? sets,
    int? minReps,
    int? maxReps,
    int? restSeconds,
    String? notes,
  }) {
    return TrainingExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      sets: sets ?? this.sets,
      minReps: minReps ?? this.minReps,
      maxReps: maxReps ?? this.maxReps,
      restSeconds: restSeconds ?? this.restSeconds,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'sets': sets,
      'minReps': minReps,
      'maxReps': maxReps,
      'restSeconds': restSeconds,
      'notes': notes,
    };
  }

  factory TrainingExercise.fromMap(
    Map<String, dynamic> map,
  ) {
    return TrainingExercise(
      exerciseId: map['exerciseId'],
      sets: map['sets'],
      minReps: map['minReps'],
      maxReps: map['maxReps'],
      restSeconds: map['restSeconds'],
      notes: map['notes'] ?? '',
    );
  }
}