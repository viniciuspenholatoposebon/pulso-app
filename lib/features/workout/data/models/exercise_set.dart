class ExerciseSet {
  final int order;

  final double weight;

  final int reps;

  final bool completed;

  final Duration? restTime;

  const ExerciseSet({
    required this.order,
    required this.weight,
    required this.reps,
    this.completed = false,
    this.restTime,
  });

  ExerciseSet copyWith({
    int? order,
    double? weight,
    int? reps,
    bool? completed,
    Duration? restTime,
  }) {
    return ExerciseSet(
      order: order ?? this.order,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      completed: completed ?? this.completed,
      restTime: restTime ?? this.restTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'order': order,
      'weight': weight,
      'reps': reps,
      'completed': completed,
      'restTime': restTime?.inSeconds,
    };
  }

  factory ExerciseSet.fromMap(Map<String, dynamic> map) {
    return ExerciseSet(
      order: map['order'],
      weight: (map['weight'] as num).toDouble(),
      reps: map['reps'],
      completed: map['completed'] ?? false,
      restTime: map['restTime'] != null
          ? Duration(seconds: map['restTime'])
          : null,
    );
  }
}