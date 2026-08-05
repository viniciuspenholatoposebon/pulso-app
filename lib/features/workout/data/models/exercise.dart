class Exercise {
  final String id;

  final String name;

  final String muscleGroupId;

  final List<String> primaryMuscleIds;

  final List<String> secondaryMuscleIds;

  final String equipmentId;

  final String level;

  final String type;

  final bool unilateral;

  final bool bilateral;

  final bool bodyweight;

  final bool machine;

  final String instructions;

  final String imageAsset;

  final String gifAsset;

  final String videoUrl;

  final bool isFavorite;

  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroupId,
    required this.primaryMuscleIds,
    required this.secondaryMuscleIds,
    required this.equipmentId,
    required this.level,
    required this.type,
    required this.unilateral,
    required this.bilateral,
    required this.bodyweight,
    required this.machine,
    required this.instructions,
    required this.imageAsset,
    required this.gifAsset,
    required this.videoUrl,
    this.isFavorite = false,
  });

  Exercise copyWith({
    String? id,
    String? name,
    String? muscleGroupId,
    List<String>? primaryMuscleIds,
    List<String>? secondaryMuscleIds,
    String? equipmentId,
    String? level,
    String? type,
    bool? unilateral,
    bool? bilateral,
    bool? bodyweight,
    bool? machine,
    String? instructions,
    String? imageAsset,
    String? gifAsset,
    String? videoUrl,
    bool? isFavorite,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      muscleGroupId: muscleGroupId ?? this.muscleGroupId,
      primaryMuscleIds: primaryMuscleIds ?? this.primaryMuscleIds,
      secondaryMuscleIds:
          secondaryMuscleIds ?? this.secondaryMuscleIds,
      equipmentId: equipmentId ?? this.equipmentId,
      level: level ?? this.level,
      type: type ?? this.type,
      unilateral: unilateral ?? this.unilateral,
      bilateral: bilateral ?? this.bilateral,
      bodyweight: bodyweight ?? this.bodyweight,
      machine: machine ?? this.machine,
      instructions: instructions ?? this.instructions,
      imageAsset: imageAsset ?? this.imageAsset,
      gifAsset: gifAsset ?? this.gifAsset,
      videoUrl: videoUrl ?? this.videoUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'muscleGroupId': muscleGroupId,
      'primaryMuscleIds': primaryMuscleIds,
      'secondaryMuscleIds': secondaryMuscleIds,
      'equipmentId': equipmentId,
      'level': level,
      'type': type,
      'unilateral': unilateral,
      'bilateral': bilateral,
      'bodyweight': bodyweight,
      'machine': machine,
      'instructions': instructions,
      'imageAsset': imageAsset,
      'gifAsset': gifAsset,
      'videoUrl': videoUrl,
      'isFavorite': isFavorite,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      muscleGroupId: map['muscleGroupId'],
      primaryMuscleIds: List<String>.from(
        map['primaryMuscleIds'] ?? [],
      ),
      secondaryMuscleIds: List<String>.from(
        map['secondaryMuscleIds'] ?? [],
      ),
      equipmentId: map['equipmentId'],
      level: map['level'],
      type: map['type'],
      unilateral: map['unilateral'] ?? false,
      bilateral: map['bilateral'] ?? true,
      bodyweight: map['bodyweight'] ?? false,
      machine: map['machine'] ?? false,
      instructions: map['instructions'] ?? '',
      imageAsset: map['imageAsset'] ?? '',
      gifAsset: map['gifAsset'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}