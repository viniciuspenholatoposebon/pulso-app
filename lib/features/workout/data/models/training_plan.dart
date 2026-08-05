class TrainingPlan {
  /// ID do plano.
  final String id;

  /// Exemplo:
  /// Hipertrofia
  /// Cutting
  /// Full Body
  final String name;

  /// Descrição opcional.
  final String description;

  /// IDs dos treinos pertencentes ao plano.
  final List<String> workoutIds;

  /// Plano ativo?
  final bool isActive;

  final DateTime createdAt;

  final DateTime updatedAt;

  const TrainingPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.workoutIds,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  TrainingPlan copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? workoutIds,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TrainingPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      workoutIds: workoutIds ?? this.workoutIds,
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
      'workoutIds': workoutIds,
      'isActive': isActive,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory TrainingPlan.fromMap(Map<String, dynamic> map) {
    return TrainingPlan(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      workoutIds: List<String>.from(
        map['workoutIds'] ?? [],
      ),
      isActive: map['isActive'] ?? true,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'],
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'],
      ),
    );
  }
}