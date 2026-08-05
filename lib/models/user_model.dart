/// Plano do usuário no app.
enum PlanType { free, plus }

/// Modelo de usuário do PULSO.
///
/// Compatível com:
/// - MockAuthService
/// - Firebase Authentication
/// - Cloud Firestore
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final bool emailVerified;
  final PlanType plan;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.emailVerified = false,
    this.plan = PlanType.free,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      photoUrl: json['photoUrl'] as String?,
      emailVerified: json['emailVerified'] as bool? ?? false,
      plan: (json['plan'] as String?) == 'plus' ? PlanType.plus : PlanType.free,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'emailVerified': emailVerified,
      'plan': plan == PlanType.plus ? 'plus' : 'free',
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    bool? emailVerified,
    PlanType? plan,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      emailVerified: emailVerified ?? this.emailVerified,
      plan: plan ?? this.plan,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, plan: $plan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is UserModel &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            email == other.email &&
            photoUrl == other.photoUrl &&
            emailVerified == other.emailVerified &&
            plan == other.plan;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      email,
      photoUrl,
      emailVerified,
      plan,
    );
  }
}
