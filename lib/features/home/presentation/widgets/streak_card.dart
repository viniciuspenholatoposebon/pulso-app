import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class StreakCard extends StatelessWidget {
  final int currentStreak;
  final int bestStreak;

  const StreakCard({
    super.key,
    required this.currentStreak,
    required this.bestStreak,
  });

  String get _message {
    if (currentStreak == 0) {
      return 'Comece hoje sua sequência!';
    }

    if (currentStreak < 7) {
      return 'Você está criando um ótimo hábito.';
    }

    if (currentStreak < 30) {
      return 'Excelente consistência! Continue assim.';
    }

    return 'Você está imparável! 🔥';
  }

  double get _progress {
    if (currentStreak == 0) {
      return 0;
    }

    if (currentStreak >= 30) {
      return 1;
    }

    return currentStreak / 30;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.volt.withValues(
            alpha: .25,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '🔥',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),

              const SizedBox(
                width: 14,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sequência Atual',
                      style:
                          AppTypography.bodySecondary,
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    Text(
                      '$currentStreak dias',
                      style:
                          AppTypography.headlineSmall
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

          LinearProgressIndicator(
            value: _progress,
            minHeight: 8,
            borderRadius:
                BorderRadius.circular(20),
            backgroundColor:
                Colors.white10,
            valueColor:
                const AlwaysStoppedAnimation(
              AppColors.volt,
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          Row(
            children: [
              Expanded(
                child: Text(
                  _message,
                  style:
                      AppTypography.body,
                ),
              ),

              Text(
                'Recorde: $bestStreak',
                style:
                    AppTypography.bodySecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}