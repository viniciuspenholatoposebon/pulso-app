import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../providers/repository_providers.dart';
import '../../../../routes/route_paths.dart';
import '../../data/enums/activity_level.dart';
import '../../data/enums/gender.dart';
import '../../data/enums/goal.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_progress.dart';
import '../widgets/onboarding_step.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  ConsumerState<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends ConsumerState<OnboardingScreen> {
  bool _isSaving = false;

  Future<void> _finishOnboarding() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    debugPrint('========== INICIO ==========');

    try {
      final controller = ref.read(
        onboardingControllerProvider.notifier,
      );

      debugPrint('Controller carregado');

      await controller.finishOnboarding();

      debugPrint('Onboarding finalizado');

      if (!mounted) return;

      debugPrint('Navegando para Home');

      context.go(RoutePaths.home);
    } catch (e, s) {
      debugPrint('========== ERRO ==========');
      debugPrint(e.toString());
      debugPrint(s.toString());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    } finally {
      debugPrint('========== FIM ==========');

      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      onboardingControllerProvider,
    );

    final controller = ref.read(
      onboardingControllerProvider.notifier,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pulso',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () async {
              final repository = ref.read(
                authRepositoryProvider,
              );

              await repository.logout();
            },
          ),
        ],
      ),
      body: IgnorePointer(
        ignoring: _isSaving,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              24,
            ),
            child: Column(
              children: [
                OnboardingProgress(
                  currentStep: state.currentStep,
                  totalSteps:
                      OnboardingController.totalSteps,
                ),
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        child: OnboardingStep(
                          key: ValueKey(
                            state.currentStep,
                          ),
                          currentStep:
                              state.currentStep,
                          nickname:
                              state.data.nickname ?? '',
                          birthDate:
                              state.data.birthDate,
                          gender:
                              state.data.gender == null
                                  ? null
                                  : Gender.values.firstWhere(
                                      (e) =>
                                          e.name ==
                                          state.data
                                              .gender,
                                    ),
                          height:
                              state.data.height,
                          weight:
                              state.data.weight,
                          goals: state.data.goals
                              .map(
                                (goal) =>
                                    Goal.values.firstWhere(
                                  (e) =>
                                      e.name ==
                                      goal,
                                ),
                              )
                              .toList(),
                          activityLevel: state
                                      .data
                                      .activityLevel ==
                                  null
                              ? null
                              : ActivityLevel.values
                                  .firstWhere(
                                  (e) =>
                                      e.name ==
                                      state.data
                                          .activityLevel,
                                ),
                          onStart:
                              controller.nextStep,
                          onNickname: (value) {
                            controller
                                .updateNickname(
                              value,
                            );
                            controller
                                .nextStep();
                          },
                          onBirthDate: (value) {
                            controller
                                .updateBirthDate(
                              value,
                            );
                            controller
                                .nextStep();
                          },
                          onGender: (value) {
                            controller
                                .updateGender(
                              value,
                            );
                            controller
                                .nextStep();
                          },
                          onHeight: (value) {
                            controller
                                .updateHeight(
                              value,
                            );
                            controller
                                .nextStep();
                          },
                          onWeight: (value) {
                            controller
                                .updateWeight(
                              value,
                            );
                            controller
                                .nextStep();
                          },
                          onGoals: (value) {
                            controller
                                .updateGoals(
                              value,
                            );
                            controller
                                .nextStep();
                          },
                          onActivityLevel:
                              (value) {
                            controller
                                .updateActivityLevel(
                              value,
                            );
                            controller
                                .nextStep();
                          },
                          onFinish:
                              _finishOnboarding,
                        ),
                      ),
                      if (_isSaving)
                        Container(
                          color: Colors.black54,
                          child: const Center(
                            child:
                                CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}