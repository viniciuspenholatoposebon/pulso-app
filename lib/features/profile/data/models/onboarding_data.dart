class OnboardingData {
  final String? nickname;
  final DateTime? birthDate;
  final String? gender;
  final double? height;
  final double? weight;
  final List<String> goals;
  final String? activityLevel;

  const OnboardingData({
    this.nickname,
    this.birthDate,
    this.gender,
    this.height,
    this.weight,
    this.goals = const [],
    this.activityLevel,
  });

  OnboardingData copyWith({
    String? nickname,
    DateTime? birthDate,
    String? gender,
    double? height,
    double? weight,
    List<String>? goals,
    String? activityLevel,
  }) {
    return OnboardingData(
      nickname: nickname ?? this.nickname,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      goals: goals ?? this.goals,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'birthDate': birthDate?.toIso8601String(),
      'gender': gender,
      'height': height,
      'weight': weight,
      'goals': goals,
      'activityLevel': activityLevel,
    };
  }

  factory OnboardingData.fromMap(Map<String, dynamic> map) {
    return OnboardingData(
      nickname: map['nickname'] as String?,
      birthDate: map['birthDate'] != null
          ? DateTime.parse(map['birthDate'] as String)
          : null,
      gender: map['gender'] as String?,
      height: (map['height'] as num?)?.toDouble(),
      weight: (map['weight'] as num?)?.toDouble(),
      goals: List<String>.from(map['goals'] ?? const []),
      activityLevel: map['activityLevel'] as String?,
    );
  }

  bool get isComplete =>
      nickname != null &&
      nickname!.isNotEmpty &&
      birthDate != null &&
      gender != null &&
      height != null &&
      weight != null &&
      goals.isNotEmpty &&
      activityLevel != null;
}
