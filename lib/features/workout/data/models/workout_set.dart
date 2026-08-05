class WorkoutSet {
  final int order;

  final double weight;

  final int reps;

  final bool completed;

  final DateTime? completedAt;

  const WorkoutSet({
    required this.order,
    required this.weight,
    required this.reps,
    this.completed = false,
    this.completedAt,
  });

  WorkoutSet copyWith({
    int? order,
    double? weight,
    int? reps,
    bool? completed,
    DateTime? completedAt,
  }) {
    return WorkoutSet(
      order: order ?? this.order,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'order': order,
      'weight': weight,
      'reps': reps,
      'completed': completed,
      'completedAt':
          completedAt?.millisecondsSinceEpoch,
    };
  }

  factory WorkoutSet.fromMap(
    Map<String, dynamic> map,
  ) {
    return WorkoutSet(
      order: map['order'],
      weight: (map['weight'] as num).toDouble(),
      reps: map['reps'],
      completed: map['completed'] ?? false,
      completedAt: map['completedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              map['completedAt'],
            ),
    );
  }
}