import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/exercise.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
  });

  final Exercise exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.surface,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: onTap,
        leading: const CircleAvatar(
          radius: 26,
          backgroundColor: AppColors.volt,
          child: Icon(
            Icons.fitness_center,
            color: AppColors.ink,
          ),
        ),
        title: Text(
          exercise.name,
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(
            top: 6,
          ),
          child: Text(
            exercise.muscleGroupId,
            style: AppTypography.bodySecondary,
          ),
        ),
        trailing: Icon(
          exercise.isFavorite
              ? Icons.favorite
              : Icons.chevron_right,
          color: exercise.isFavorite
              ? AppColors.signal
              : AppColors.mist,
        ),
      ),
    );
  }
}