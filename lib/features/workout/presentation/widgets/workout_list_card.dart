import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/models/workout.dart';
import '../screens/workout_detail_screen.dart';

class WorkoutListCard extends StatelessWidget {
  const WorkoutListCard({
    super.key,
    required this.workout,
  });

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      color: AppColors.surface,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => WorkoutDetailScreen(
                workout: workout,
              ),
            ),
          );
        },
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
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${workout.exercises.length} exercícios • ${workout.estimatedDuration} min',
          style: AppTypography.bodySecondary,
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }
}