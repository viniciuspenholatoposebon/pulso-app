class ExerciseSetExecution {
  /// Número da série.
  final int setNumber;

  /// Peso utilizado.
  final double weight;

  /// Repetições realizadas.
  final int reps;

  /// RPE (1 a 10)
  final double? rpe;

  /// Descanso realizado.
  final int restSeconds;

  /// Tempo da série.
  final int durationSeconds;

  /// Foi até a falha?
  final bool failure;

  /// Foi recorde pessoal?
  final bool personalRecord;

  /// Observações.
  final String? notes;

  /// Horário da execução.
  final DateTime executedAt;

  const ExerciseSetExecution({
    required this.setNumber,
    required this.weight,
    required this.reps,
    required this.restSeconds,
    required this.durationSeconds,
    required this.executedAt,
    this.rpe,
    this.failure = false,
    this.personalRecord = false,
    this.notes,
  });

  ExerciseSetExecution copyWith({
    int? setNumber,
    double? weight,
    int? reps,
    double? rpe,
    int? restSeconds,
    int? durationSeconds,
    bool? failure,
    bool? personalRecord,
    String? notes,
    DateTime? executedAt,
  }) {
    return ExerciseSetExecution(
      setNumber: setNumber ?? this.setNumber,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      rpe: rpe ?? this.rpe,
      restSeconds: restSeconds ?? this.restSeconds,
      durationSeconds:
          durationSeconds ?? this.durationSeconds,
      failure: failure ?? this.failure,
      personalRecord:
          personalRecord ?? this.personalRecord,
      notes: notes ?? this.notes,
      executedAt: executedAt ?? this.executedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'setNumber': setNumber,
      'weight': weight,
      'reps': reps,
      'rpe': rpe,
      'restSeconds': restSeconds,
      'durationSeconds': durationSeconds,
      'failure': failure,
      'personalRecord': personalRecord,
      'notes': notes,
      'executedAt':
          executedAt.millisecondsSinceEpoch,
    };
  }

  factory ExerciseSetExecution.fromMap(
    Map<String, dynamic> map,
  ) {
    return ExerciseSetExecution(
      setNumber: map['setNumber'],
      weight: (map['weight'] as num).toDouble(),
      reps: map['reps'],
      rpe: map['rpe'] != null
          ? (map['rpe'] as num).toDouble()
          : null,
      restSeconds: map['restSeconds'],
      durationSeconds: map['durationSeconds'],
      failure: map['failure'] ?? false,
      personalRecord:
          map['personalRecord'] ?? false,
      notes: map['notes'],
      executedAt:
          DateTime.fromMillisecondsSinceEpoch(
        map['executedAt'],
      ),
    );
  }
}