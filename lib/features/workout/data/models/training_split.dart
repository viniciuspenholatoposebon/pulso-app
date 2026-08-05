class TrainingSplit {
  final String id;

  final String name;

  final int trainingDays;

  final List<String> weekDays;

  final List<String> muscleGroups;

  const TrainingSplit({
    required this.id,
    required this.name,
    required this.trainingDays,
    required this.weekDays,
    required this.muscleGroups,
  });

  TrainingSplit copyWith({
    String? id,
    String? name,
    int? trainingDays,
    List<String>? weekDays,
    List<String>? muscleGroups,
  }) {
    return TrainingSplit(
      id: id ?? this.id,
      name: name ?? this.name,
      trainingDays: trainingDays ?? this.trainingDays,
      weekDays: weekDays ?? this.weekDays,
      muscleGroups: muscleGroups ?? this.muscleGroups,
    );
  }
}