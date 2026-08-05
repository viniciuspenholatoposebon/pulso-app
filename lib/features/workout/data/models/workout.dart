import 'workout_exercise.dart';

class Workout {
  /// ID único do treino.
  final String id;

  /// Nome do treino.
  /// Ex.: Treino A, Push, Pull...
  final String name;

  /// Descrição opcional.
  final String description;

  /// Cor do treino (Hex).
  /// Ex.: #C9FF3D
  final String? color;

  /// Ícone do treino.
  /// Ex.: fitness_center
  final String? icon;

  /// Dias da semana.
  /// Ex.:
  /// ['Monday', 'Thursday']
  final List<String> weekDays;

  /// Exercícios.
  final List<WorkoutExercise> exercises;

  /// Tempo estimado (minutos).
  final int estimatedDuration;

  /// É um treino modelo?
  /// (Templates oficiais do Pulso)
  final bool isTemplate;

  /// Está ativo?
  final bool isActive;

  final DateTime createdAt;

  final DateTime updatedAt;

  const Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.weekDays,
    required this.exercises,
    required this.estimatedDuration,
    required this.createdAt,
    required this.updatedAt,
    this.color,
    this.icon,
    this.isTemplate = false,
    this.isActive = true,
  });

  Workout copyWith({
    String? id,
    String? name,
    String? description,
    String? color,
    String? icon,
    List<String>? weekDays,
    List<WorkoutExercise>? exercises,
    int? estimatedDuration,
    bool? isTemplate,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      weekDays: weekDays ?? this.weekDays,
      exercises: exercises ?? this.exercises,
      estimatedDuration:
          estimatedDuration ?? this.estimatedDuration,
      isTemplate: isTemplate ?? this.isTemplate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'color': color,
      'icon': icon,
      'weekDays': weekDays,
      'exercises': exercises
          .map(
            (e) => e.toMap(),
          )
          .toList(),
      'estimatedDuration': estimatedDuration,
      'isTemplate': isTemplate,
      'isActive': isActive,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Workout.fromMap(
    Map<String, dynamic> map,
  ) {
    return Workout(
      id: map['id'],
      name: map['name'],
      description: map['description'] ?? '',
      color: map['color'],
      icon: map['icon'],
      weekDays: List<String>.from(
        map['weekDays'] ?? [],
      ),
      exercises: (map['exercises'] as List<dynamic>? ?? [])
          .map(
            (e) => WorkoutExercise.fromMap(
              Map<String, dynamic>.from(e),
            ),
          )
          .toList(),
      estimatedDuration:
          map['estimatedDuration'] ?? 0,
      isTemplate:
          map['isTemplate'] ?? false,
      isActive:
          map['isActive'] ?? true,
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'],
      ),
      updatedAt:
          DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'],
      ),
    );
  }
}