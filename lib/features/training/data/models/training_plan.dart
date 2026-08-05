import 'training_exercise.dart';

class TrainingPlan {
  final String id;

  final String name;

  final String description;

  final bool isActive;

  final DateTime createdAt;

  final DateTime updatedAt;

  final List<TrainingExercise> exercises;

  const TrainingPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.exercises,
    this.isActive = true,
  });

  TrainingPlan copyWith({
    String? id,
    String? name,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TrainingExercise>? exercises,
  }) {
    return TrainingPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isActive': isActive,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'exercises': exercises
          .map(
            (e) => e.toMap(),
          )
          .toList(),
    };
  }

  factory TrainingPlan.fromMap(
    Map<String, dynamic> map,
  ) {
    return TrainingPlan(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      isActive: map['isActive'] ?? true,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'],
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'],
      ),
      exercises: (map['exercises'] as List<dynamic>)
          .map(
            (e) => TrainingExercise.fromMap(
              Map<String, dynamic>.from(e),
            ),
          )
          .toList(),
    );
  }
}