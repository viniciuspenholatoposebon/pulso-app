import '../../data/models/onboarding_data.dart';

class OnboardingState {
  final int currentStep;
  final OnboardingData data;

  const OnboardingState({
    this.currentStep = 0,
    this.data = const OnboardingData(),
  });

  OnboardingState copyWith({
    int? currentStep,
    OnboardingData? data,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      data: data ?? this.data,
    );
  }
}
