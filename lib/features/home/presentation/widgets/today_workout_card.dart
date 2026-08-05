import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/pulso_primary_button.dart';

class TodayWorkoutCard extends StatelessWidget {
  final String workoutName;
  final int exercises;
  final int estimatedMinutes;
  final bool completed;
  final bool restDay;
  final VoidCallback onStart;

  const TodayWorkoutCard({
    super.key,
    required this.workoutName,
    required this.exercises,
    required this.estimatedMinutes,
    required this.completed,
    required this.restDay,
    required this.onStart,
  });

  String get _title {
    if (restDay) {
      return 'Dia de descanso';
    }

    if (completed) {
      return 'Treino concluído';
    }

    return 'Treino de Hoje';
  }

  String get _buttonLabel {
    if (completed) {
      return 'TREINO FINALIZADO';
    }

    if (restDay) {
      return 'VER PRÓXIMO TREINO';
    }

    return 'INICIAR TREINO';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.volt.withValues(
            alpha: .20,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color:
                      AppColors.volt.withValues(
                    alpha: .12,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.fitness_center,
                  color: AppColors.volt,
                  size: 28,
                ),
              ),

              const SizedBox(
                width: 18,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      _title,
                      style:
                          AppTypography.bodySecondary,
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      workoutName,
                      style: AppTypography
                          .headlineSmall
                          .copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 24,
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color:
                        Colors.white.withValues(
                      alpha: .05,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.list_alt,
                        color: AppColors.volt,
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        '$exercises',
                        style: AppTypography
                            .titleLarge
                            .copyWith(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        'Exercícios',
                        style:
                            AppTypography.bodySecondary,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                width: 14,
              ),

              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color:
                        Colors.white.withValues(
                      alpha: .05,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.schedule,
                        color: AppColors.volt,
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        '$estimatedMinutes min',
                        style: AppTypography
                            .titleLarge
                            .copyWith(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        'Tempo',
                        style:
                            AppTypography.bodySecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 24,
          ),

          SizedBox(
            width: double.infinity,
            child: PulsoPrimaryButton(
              label: _buttonLabel,
              onPressed: onStart,
            ),
          ),
        ],
      ),
    );
  }
}