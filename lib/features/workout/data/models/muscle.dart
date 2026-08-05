class Muscle {
  final String id;

  final String name;

  const Muscle({
    required this.id,
    required this.name,
  });

  Muscle copyWith({
    String? id,
    String? name,
  }) {
    return Muscle(
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

  factory Muscle.fromMap(Map<String, dynamic> map) {
    return Muscle(
      id: map['id'],
      name: map['name'],
    );
  }
}