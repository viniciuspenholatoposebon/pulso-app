import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../screens/workout_history_detail/workout_history_detail_screen.dart';
import '../../data/models/workout_session.dart';


class WorkoutHistoryCard extends StatelessWidget {
  const WorkoutHistoryCard({
    super.key,
    required this.session,
  });

  final WorkoutSession session;


  @override
  Widget build(
    BuildContext context,
  ) {

    return InkWell(

      borderRadius:
          BorderRadius.circular(24),


      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                WorkoutHistoryDetailScreen(
              session:
                  session,
            ),
          ),
        );

      },


      child: Container(

        margin:
            const EdgeInsets.only(
          bottom:
              16,
        ),


        padding:
            const EdgeInsets.all(20),


        decoration:
            BoxDecoration(

          color:
              AppColors.ink,


          borderRadius:
              BorderRadius.circular(24),


          border: Border.all(
            color:
                AppColors.volt.withValues(
              alpha: .20,
            ),
          ),
        ),


        child:
            Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [


            Row(

              children: [


                Container(

                  width:
                      48,


                  height:
                      48,


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

                        session.workoutName,


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
                          session.startedAt,
                        ),


                        style:
                            AppTypography.bodySecondary,
                      ),
                    ],
                  ),
                ),



                const Icon(
                  Icons.chevron_right,
                  color:
                      AppColors.volt,
                ),
              ],
            ),



            const SizedBox(
              height:
                  20,
            ),



            Row(

              children: [


                Expanded(

                  child:
                      _InfoItem(

                    icon:
                        Icons.timer_outlined,


                    label:
                        '${session.durationMinutes} min',


                    title:
                        'Duração',
                  ),
                ),



                const SizedBox(
                  width:
                      12,
                ),



                Expanded(

                  child:
                      _InfoItem(

                    icon:
                        Icons.fitness_center,


                    label:
                        '${session.exercises.length}',


                    title:
                        'Exercícios',
                  ),
                ),
              ],
            ),



            const SizedBox(
              height:
                  12,
            ),



            Row(

              children: [


                Expanded(

                  child:
                      _InfoItem(

                    icon:
                        Icons.repeat,


                    label:
                        '${session.completedSets}/${session.totalSets}',


                    title:
                        'Séries',
                  ),
                ),



                const SizedBox(
                  width:
                      12,
                ),



                Expanded(

                  child:
                      _InfoItem(

                    icon:
                        Icons.local_fire_department,


                    label:
                        '${session.totalVolume.toStringAsFixed(0)} kg',


                    title:
                        'Volume',
                  ),
                ),
              ],
            ),
          ],
        ),
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




class _InfoItem extends StatelessWidget {

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.label,
  });


  final IconData icon;

  final String title;

  final String label;



  @override
  Widget build(
    BuildContext context,
  ) {

    return Container(

      padding:
          const EdgeInsets.all(14),


      decoration:
          BoxDecoration(

        color:
            Colors.white.withValues(
          alpha: .05,
        ),


        borderRadius:
            BorderRadius.circular(18),
      ),


      child:
          Column(

        children: [


          Icon(
            icon,

            color:
                AppColors.volt,
          ),



          const SizedBox(
            height:
                8,
          ),



          Text(

            label,


            style:
                AppTypography.body.copyWith(
              fontWeight:
                  FontWeight.bold,
            ),
          ),



          const SizedBox(
            height:
                2,
          ),



          Text(

            title,


            style:
                AppTypography.bodySecondary,
          ),
        ],
      ),
    );
  }
}