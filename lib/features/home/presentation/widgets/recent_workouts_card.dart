import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../routes/route_paths.dart';
import '../../../workout/data/models/workout_session.dart';


class RecentWorkoutsCard extends StatelessWidget {
  const RecentWorkoutsCard({
    super.key,
    required this.workouts,
  });

  final List<WorkoutSession> workouts;


  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        24,
        0,
        24,
        24,
      ),

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color:
            AppColors.ink,

        borderRadius:
            BorderRadius.circular(24),

        border: Border.all(
          color:
              AppColors.volt.withValues(
            alpha: .18,
          ),
        ),
      ),


      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Text(
                'Últimos Treinos',

                style:
                    AppTypography.headlineSmall.copyWith(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),


              if (workouts.isNotEmpty)

                TextButton(
                  onPressed: () {

                    context.push(
                      RoutePaths.workoutHistory,
                    );

                  },

                  child:
                      const Text(
                    'VER TODOS',
                  ),
                ),
            ],
          ),


          const SizedBox(
            height: 20,
          ),


          if (workouts.isEmpty)

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                vertical: 16,
              ),

              child:
                  Center(
                child:
                    Text(
                  'Nenhum treino realizado ainda.',

                  style:
                      AppTypography.bodySecondary,
                ),
              ),
            )


          else

            ...workouts.take(5).map(
              (
                workout,
              ) {

                return Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 14,
                  ),

                  child:
                      Row(
                    children: [

                      Container(
                        width:
                            42,

                        height:
                            42,

                        decoration:
                            BoxDecoration(
                          color:
                              AppColors.volt.withValues(
                            alpha: .12,
                          ),

                          shape:
                              BoxShape.circle,
                        ),

                        child:
                            const Icon(
                          Icons.check_circle,

                          color:
                              AppColors.volt,
                        ),
                      ),


                      const SizedBox(
                        width:
                            14,
                      ),


                      Expanded(
                        child:
                            Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              'Treino concluído',

                              style:
                                  AppTypography.body.copyWith(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),


                            const SizedBox(
                              height:
                                  4,
                            ),


                            Text(
                              '${workout.exercises.length} exercícios',

                              style:
                                  AppTypography.bodySecondary,
                            ),
                          ],
                        ),
                      ),


                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,

                        children: [

                          Text(
                            '${workout.durationMinutes} min',

                            style:
                                AppTypography.body.copyWith(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),


                          const SizedBox(
                            height:
                                4,
                          ),


                          Text(
                            _formatDate(
                              workout.startedAt,
                            ),

                            style:
                                AppTypography.bodySecondary,
                          ),
                        ],
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


  String _formatDate(
    DateTime date,
  ) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}