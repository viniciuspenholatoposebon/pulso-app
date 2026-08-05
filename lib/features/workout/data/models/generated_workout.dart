class GeneratedWorkout {
  final String workoutName;

  final String weekDay;

  final String muscleGroup;

  final List<String> exercises;

  const GeneratedWorkout({
    required this.workoutName,
    required this.weekDay,
    required this.muscleGroup,
    required this.exercises,
  });

  GeneratedWorkout copyWith({
    String? workoutName,
    String? weekDay,
    String? muscleGroup,
    List<String>? exercises,
  }) {
    return GeneratedWorkout(
      workoutName: workoutName ?? this.workoutName,
      weekDay: weekDay ?? this.weekDay,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      exercises: exercises ?? this.exercises,
    );
  }
}