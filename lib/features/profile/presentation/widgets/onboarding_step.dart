import 'package:flutter/material.dart';

import '../../data/enums/activity_level.dart';
import '../../data/enums/gender.dart';
import '../../data/enums/goal.dart';

import 'steps/activity_level_step.dart';
import 'steps/birth_date_step.dart';
import 'steps/finish_step.dart';
import 'steps/gender_step.dart';
import 'steps/goal_step.dart';
import 'steps/height_step.dart';
import 'steps/nickname_step.dart';
import 'steps/weight_step.dart';
import 'steps/welcome_step.dart';

class OnboardingStep extends StatelessWidget {
  final int currentStep;

  final String nickname;
  final DateTime? birthDate;
  final Gender? gender;
  final double? height;
  final double? weight;

  final List<Goal> goals;

  final ActivityLevel? activityLevel;

  final VoidCallback onStart;

  final ValueChanged<String> onNickname;
  final ValueChanged<DateTime> onBirthDate;
  final ValueChanged<Gender> onGender;
  final ValueChanged<double> onHeight;
  final ValueChanged<double> onWeight;

  final ValueChanged<List<Goal>> onGoals;

  final ValueChanged<ActivityLevel> onActivityLevel;

  final VoidCallback onFinish;

  const OnboardingStep({
    super.key,
    required this.currentStep,
    required this.nickname,
    required this.birthDate,
    required this.gender,
    required this.height,
    required this.weight,
    required this.goals,
    required this.activityLevel,
    required this.onStart,
    required this.onNickname,
    required this.onBirthDate,
    required this.onGender,
    required this.onHeight,
    required this.onWeight,
    required this.onGoals,
    required this.onActivityLevel,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    switch (currentStep) {
      case 0:
        return WelcomeStep(
          onStart: onStart,
        );

      case 1:
        return NicknameStep(
          initialValue: nickname,
          onNext: onNickname,
        );

      case 2:
        return BirthDateStep(
          initialValue: birthDate,
          onNext: onBirthDate,
        );

      case 3:
        return GenderStep(
          initialValue: gender,
          onNext: onGender,
        );

      case 4:
        return HeightStep(
          initialValue: height,
          onNext: onHeight,
        );

      case 5:
        return WeightStep(
          initialValue: weight,
          onNext: onWeight,
        );

      case 6:
        return GoalStep(
          initialValue: goals,
          onNext: onGoals,
        );

      case 7:
        return ActivityLevelStep(
          initialValue: activityLevel,
          onNext: onActivityLevel,
        );

      case 8:
        return FinishStep(
          onFinish: onFinish,
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
