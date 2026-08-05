import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../data/models/workout_session.dart';

class WorkoutHistoryDetailScreen extends StatelessWidget {
  const WorkoutHistoryDetailScreen({
    super.key,
    required this.session,
  });

  final WorkoutSession session;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          session.workoutName,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          _SummaryCard(
            session: session,
          ),

          const SizedBox(
            height: 24,
          ),

          Text(
            'Exercícios realizados',
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          ...session.exercises.map(
            (
              exercise,
            ) {
              return Container(
                margin: const EdgeInsets.only(
                  bottom: 16,
                ),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.ink,
                  borderRadius:
                      BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      exercise.exerciseName,
                      style:
                          AppTypography.body.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    ...exercise.sets.map(
                      (
                        set,
                      ) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [

                              Text(
                                'Série ${set.order}',
                              ),

                              Text(
                                '${set.weight.toStringAsFixed(1)} kg • ${set.reps} reps',
                              ),

                              Icon(
                                set.completed
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color:
                                    set.completed
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.session,
  });

  final WorkoutSession session;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color:
              AppColors.volt.withValues(
            alpha: .20,
          ),
        ),
      ),
      child: Column(
        children: [

          Text(
            'Resumo',
            style:
                AppTypography.headlineSmall.copyWith(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          _InfoRow(
            title: 'Duração',
            value:
                '${session.durationMinutes} min',
          ),

          _InfoRow(
            title: 'Exercícios',
            value:
                '${session.exercises.length}',
          ),

          _InfoRow(
            title: 'Séries',
            value:
                '${session.completedSets}/${session.totalSets}',
          ),

          _InfoRow(
            title: 'Volume',
            value:
                '${session.totalVolume.toStringAsFixed(0)} kg',
          ),
        ],
      ),
    );
  }
}


class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [

          Text(
            title,
            style:
                AppTypography.bodySecondary,
          ),

          Text(
            value,
            style:
                AppTypography.body.copyWith(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}