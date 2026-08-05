class WorkoutExercise {
  /// ID do exercício.
  final String exerciseId;

  /// Ordem do exercício dentro do treino.
  final int order;

  /// Quantidade de séries.
  final int sets;

  /// Repetições mínimas.
  final int minReps;

  /// Repetições máximas.
  final int maxReps;

  /// Descanso em segundos.
  final int restSeconds;

  /// Repetições em reserva (RIR).
  /// Ex.: 0 = falha, 1 = sobrou 1 repetição.
  final int? rir;

  /// Cadência do movimento.
  /// Ex.: 3-1-1-0
  final String? tempo;

  /// É uma série de aquecimento?
  final bool warmUp;

  /// Dropset.
  final bool dropSet;

  /// Biset.
  final bool biSet;

  /// Supersérie.
  final bool superSet;

  /// Observações.
  final String? notes;

  const WorkoutExercise({
    required this.exerciseId,
    required this.order,
    required this.sets,
    required this.minReps,
    required this.maxReps,
    required this.restSeconds,
    this.rir,
    this.tempo,
    this.warmUp = false,
    this.dropSet = false,
    this.biSet = false,
    this.superSet = false,
    this.notes,
  });

  WorkoutExercise copyWith({
    String? exerciseId,
    int? order,
    int? sets,
    int? minReps,
    int? maxReps,
    int? restSeconds,
    int? rir,
    String? tempo,
    bool? warmUp,
    bool? dropSet,
    bool? biSet,
    bool? superSet,
    String? notes,
  }) {
    return WorkoutExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
      sets: sets ?? this.sets,
      minReps: minReps ?? this.minReps,
      maxReps: maxReps ?? this.maxReps,
      restSeconds: restSeconds ?? this.restSeconds,
      rir: rir ?? this.rir,
      tempo: tempo ?? this.tempo,
      warmUp: warmUp ?? this.warmUp,
      dropSet: dropSet ?? this.dropSet,
      biSet: biSet ?? this.biSet,
      superSet: superSet ?? this.superSet,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'order': order,
      'sets': sets,
      'minReps': minReps,
      'maxReps': maxReps,
      'restSeconds': restSeconds,
      'rir': rir,
      'tempo': tempo,
      'warmUp': warmUp,
      'dropSet': dropSet,
      'biSet': biSet,
      'superSet': superSet,
      'notes': notes,
    };
  }

  factory WorkoutExercise.fromMap(
    Map<String, dynamic> map,
  ) {
    return WorkoutExercise(
      exerciseId: map['exerciseId'],
      order: map['order'],
      sets: map['sets'],
      minReps: map['minReps'],
      maxReps: map['maxReps'],
      restSeconds: map['restSeconds'],
      rir: map['rir'],
      tempo: map['tempo'],
      warmUp: map['warmUp'] ?? false,
      dropSet: map['dropSet'] ?? false,
      biSet: map['biSet'] ?? false,
      superSet: map['superSet'] ?? false,
      notes: map['notes'],
    );
  }
}