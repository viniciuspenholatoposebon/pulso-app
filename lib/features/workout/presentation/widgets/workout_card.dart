import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/workout.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onTap,
  });

  final Workout workout;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.surface,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: const CircleAvatar(
          backgroundColor: AppColors.volt,
          child: Icon(
            Icons.fitness_center,
            color: AppColors.ink,
          ),
        ),
        title: Text(
          workout.name,
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(
            top: 4,
          ),
          child: Text(
            '${workout.exercises.length} exercícios',
            style: AppTypography.bodySecondary,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.mist,
        ),
      ),
    );
  }
}