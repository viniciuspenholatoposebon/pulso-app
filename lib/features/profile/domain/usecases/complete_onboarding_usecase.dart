import '../../data/models/onboarding_data.dart';
import '../../data/models/user_profile.dart';
import '../repositories/profile_repository.dart';

class CompleteOnboardingUseCase {
  final ProfileRepository repository;

  const CompleteOnboardingUseCase({
    required this.repository,
  });

  Future<void> call({
    required String uid,
    required String email,
    required OnboardingData data,
  }) async {
    if (!data.isComplete) {
      throw Exception('Dados do onboarding incompletos.');
    }

    final now = DateTime.now();

    final age = _calculateAge(
      data.birthDate!,
      now,
    );

    final bmi = _calculateBmi(
      heightCm: data.height!,
      weightKg: data.weight!,
    );

    final bmr = _calculateBmr(
      gender: data.gender!,
      age: age,
      heightCm: data.height!,
      weightKg: data.weight!,
    );

    final profile = UserProfile(
      uid: uid,
      email: email,
      nickname: data.nickname!,
      birthDate: data.birthDate!,
      gender: data.gender!,
      height: data.height!,
      weight: data.weight!,
      goals: data.goals,
      activityLevel: data.activityLevel!,
      bmi: bmi,
      bmr: bmr,
      onboardingCompleted: true,
      createdAt: now,
      updatedAt: now,
    );

    await repository.saveProfile(profile);
  }

  int _calculateAge(
    DateTime birthDate,
    DateTime now,
  ) {
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  double _calculateBmi({
    required double heightCm,
    required double weightKg,
  }) {
    final heightMeters = heightCm / 100;

    return weightKg / (heightMeters * heightMeters);
  }

  double _calculateBmr({
    required String gender,
    required int age,
    required double weightKg,
    required double heightCm,
  }) {
    switch (gender) {
      case 'male':
        return (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;

      case 'female':
        return (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;

      default:
        throw Exception('Sexo inválido.');
    }
  }
}
