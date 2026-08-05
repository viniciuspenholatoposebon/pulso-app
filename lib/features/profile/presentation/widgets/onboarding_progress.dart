import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class OnboardingProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const OnboardingProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentStep + 1) / totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Etapa ${currentStep + 1}',
              style: AppTypography.bodySecondary.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              '${(progress * 100).round()}%',
              style: AppTypography.bodySecondary.copyWith(
                color: AppColors.volt,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: const Duration(milliseconds: 350),
            builder: (context, value, child) {
              return LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: AppColors.mist.withValues(alpha: .18),
                valueColor: const AlwaysStoppedAnimation(
                  AppColors.volt,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
