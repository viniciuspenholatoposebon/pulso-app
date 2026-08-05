import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import '../../data/enums/activity_level.dart';
import '../../data/enums/gender.dart';
import '../../data/enums/goal.dart';
import '../../domain/usecases/complete_onboarding_usecase.dart';
import 'onboarding_state.dart';

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>(
  (ref) => OnboardingController(
    completeOnboardingUseCase: CompleteOnboardingUseCase(
      repository: ref.watch(profileRepositoryProvider),
    ),
  ),
);

class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController({
    required CompleteOnboardingUseCase completeOnboardingUseCase,
  })  : _completeOnboardingUseCase = completeOnboardingUseCase,
        super(const OnboardingState());

  final CompleteOnboardingUseCase _completeOnboardingUseCase;

  /// Welcome + 7 etapas + Final
  static const int totalSteps = 9;

  int get currentStep => state.currentStep;

  bool get isFirstStep => currentStep == 0;

  bool get isLastStep => currentStep == totalSteps - 1;

  void nextStep() {
    if (!isLastStep) {
      state = state.copyWith(
        currentStep: currentStep + 1,
      );
    }
  }

  void previousStep() {
    if (!isFirstStep) {
      state = state.copyWith(
        currentStep: currentStep - 1,
      );
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < totalSteps) {
      state = state.copyWith(
        currentStep: step,
      );
    }
  }

  void updateNickname(String nickname) {
    state = state.copyWith(
      data: state.data.copyWith(
        nickname: nickname,
      ),
    );
  }

  void updateBirthDate(DateTime birthDate) {
    state = state.copyWith(
      data: state.data.copyWith(
        birthDate: birthDate,
      ),
    );
  }

  void updateGender(Gender gender) {
    state = state.copyWith(
      data: state.data.copyWith(
        gender: gender.name,
      ),
    );
  }

  void updateHeight(double height) {
    state = state.copyWith(
      data: state.data.copyWith(
        height: height,
      ),
    );
  }

  void updateWeight(double weight) {
    state = state.copyWith(
      data: state.data.copyWith(
        weight: weight,
      ),
    );
  }

  void updateGoals(List<Goal> goals) {
    state = state.copyWith(
      data: state.data.copyWith(
        goals: goals.map((goal) => goal.name).toList(),
      ),
    );
  }

  void updateActivityLevel(ActivityLevel activityLevel) {
    state = state.copyWith(
      data: state.data.copyWith(
        activityLevel: activityLevel.name,
      ),
    );
  }

  Future<void> finishOnboarding() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado.');
    }

    await _completeOnboardingUseCase(
      uid: user.uid,
      email: user.email ?? '',
      data: state.data,
    );
  }

  void reset() {
    state = const OnboardingState();
  }
}
