import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;

  final String email;

  final String nickname;

  final DateTime birthDate;

  final String gender;

  final double height;

  final double weight;

  final List<String> goals;

  final String activityLevel;

  final double bmi;

  final double bmr;

  final bool onboardingCompleted;

  final DateTime createdAt;

  final DateTime updatedAt;

  const UserProfile({
    required this.uid,
    required this.email,
    required this.nickname,
    required this.birthDate,
    required this.gender,
    required this.height,
    required this.weight,
    required this.goals,
    required this.activityLevel,
    required this.bmi,
    required this.bmr,
    required this.onboardingCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nickname': nickname,
      'birthDate': Timestamp.fromDate(birthDate),
      'gender': gender,
      'height': height,
      'weight': weight,
      'goals': goals,
      'activityLevel': activityLevel,
      'bmi': bmi,
      'bmr': bmr,
      'onboardingCompleted': onboardingCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] as String,
      email: map['email'] as String,
      nickname: map['nickname'] as String,
      birthDate: (map['birthDate'] as Timestamp).toDate(),
      gender: map['gender'] as String,
      height: (map['height'] as num).toDouble(),
      weight: (map['weight'] as num).toDouble(),
      goals: List<String>.from(map['goals'] ?? const []),
      activityLevel: map['activityLevel'] as String,
      bmi: (map['bmi'] as num).toDouble(),
      bmr: (map['bmr'] as num).toDouble(),
      onboardingCompleted: map['onboardingCompleted'] as bool? ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  UserProfile copyWith({
    String? uid,
    String? email,
    String? nickname,
    DateTime? birthDate,
    String? gender,
    double? height,
    double? weight,
    List<String>? goals,
    String? activityLevel,
    double? bmi,
    double? bmr,
    bool? onboardingCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      goals: goals ?? this.goals,
      activityLevel: activityLevel ?? this.activityLevel,
      bmi: bmi ?? this.bmi,
      bmr: bmr ?? this.bmr,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
