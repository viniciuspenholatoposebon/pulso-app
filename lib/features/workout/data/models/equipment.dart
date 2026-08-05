class Equipment {
  final String id;

  final String name;

  const Equipment({
    required this.id,
    required this.name,
  });

  Equipment copyWith({
    String? id,
    String? name,
  }) {
    return Equipment(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Equipment.fromMap(Map<String, dynamic> map) {
    return Equipment(
      id: map['id'],
      name: map['name'],
    );
  }
}