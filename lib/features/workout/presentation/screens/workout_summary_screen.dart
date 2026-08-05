import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../routes/route_paths.dart';
import '../../data/models/workout_session.dart';


class WorkoutSummaryScreen extends StatelessWidget {
  const WorkoutSummaryScreen({
    super.key,
    required this.session,
  });

  final WorkoutSession session;


  int get _totalSets {
    return session.exercises.fold(
      0,
      (
        total,
        exercise,
      ) {
        return total + exercise.sets.length;
      },
    );
  }


  int get _completedSets {
    return session.exercises.fold(
      0,
      (
        total,
        exercise,
      ) {
        return total +
            exercise.sets
                .where(
                  (set) => set.completed,
                )
                .length;
      },
    );
  }


  int get _totalExercises {
    return session.exercises.length;
  }


  double get _totalVolume {
    return session.exercises.fold(
      0,
      (
        total,
        exercise,
      ) {
        return total +
            exercise.sets.fold(
              0,
              (
                setTotal,
                set,
              ) {
                return setTotal +
                    (set.weight * set.reps);
              },
            );
      },
    );
  }


  double get _completionPercentage {
    if (_totalSets == 0) {
      return 0;
    }

    return (_completedSets / _totalSets) * 100;
  }


  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(

      appBar: AppBar(
        title:
            const Text(
          'Resumo do treino',
        ),
      ),


      body: SafeArea(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(24),


          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.stretch,


            children: [


              const SizedBox(
                height: 20,
              ),


              Container(

                padding:
                    const EdgeInsets.all(28),


                decoration:
                    BoxDecoration(

                  color:
                      AppColors.ink,

                  borderRadius:
                      BorderRadius.circular(28),


                  border: Border.all(
                    color:
                        AppColors.volt.withValues(
                      alpha: .25,
                    ),
                  ),
                ),


                child:
                    Column(

                  children: [


                    const Text(
                      '🔥',

                      style:
                          TextStyle(
                        fontSize:
                            60,
                      ),
                    ),


                    const SizedBox(
                      height:
                          16,
                    ),


                    Text(
                      'Treino concluído!',

                      style:
                          AppTypography.headlineMedium.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),


                    const SizedBox(
                      height:
                          8,
                    ),


                    Text(
                      'Excelente trabalho. Continue evoluindo!',

                      textAlign:
                          TextAlign.center,


                      style:
                          AppTypography.bodySecondary,
                    ),
                  ],
                ),
              ),


              const SizedBox(
                height:
                    24,
              ),



              Row(

                children: [


                  Expanded(
                    child:
                        _StatCard(
                      icon:
                          Icons.timer_outlined,

                      title:
                          'Tempo',

                      value:
                          '${session.durationMinutes} min',
                    ),
                  ),


                  const SizedBox(
                    width:
                        16,
                  ),


                  Expanded(
                    child:
                        _StatCard(
                      icon:
                          Icons.fitness_center,

                      title:
                          'Séries',

                      value:
                          '$_completedSets/$_totalSets',
                    ),
                  ),
                ],
              ),



              const SizedBox(
                height:
                    16,
              ),



              Row(

                children: [


                  Expanded(
                    child:
                        _StatCard(
                      icon:
                          Icons.list_alt,

                      title:
                          'Exercícios',

                      value:
                          '$_totalExercises',
                    ),
                  ),


                  const SizedBox(
                    width:
                        16,
                  ),


                  Expanded(
                    child:
                        _StatCard(
                      icon:
                          Icons.check_circle_outline,

                      title:
                          'Conclusão',

                      value:
                          '${_completionPercentage.toStringAsFixed(0)}%',
                    ),
                  ),
                ],
              ),



              const SizedBox(
                height:
                    16,
              ),



              _StatCard(

                icon:
                    Icons.local_fire_department,


                title:
                    'Volume total',


                value:
                    '${_totalVolume.toStringAsFixed(0)} kg',
              ),



              const SizedBox(
                height:
                    32,
              ),



              SizedBox(

                width:
                    double.infinity,


                child:
                    FilledButton(

                  onPressed: () {

                    context.push(
                      RoutePaths.workoutHistory,
                    );

                  },


                  child:
                      const Padding(

                    padding:
                        EdgeInsets.symmetric(
                      vertical:
                          16,
                    ),


                    child:
                        Text(
                      'VER HISTÓRICO',
                    ),
                  ),
                ),
              ),



              const SizedBox(
                height:
                    12,
              ),



              SizedBox(

                width:
                    double.infinity,


                child:
                    OutlinedButton(

                  onPressed: () {

                    context.go(
                      RoutePaths.home,
                    );

                  },


                  child:
                      const Padding(

                    padding:
                        EdgeInsets.symmetric(
                      vertical:
                          16,
                    ),


                    child:
                        Text(
                      'VOLTAR PARA HOME',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _StatCard extends StatelessWidget {

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });


  final IconData icon;
  final String title;
  final String value;



  @override
  Widget build(
    BuildContext context,
  ) {

    return Container(

      padding:
          const EdgeInsets.all(20),


      decoration:
          BoxDecoration(

        color:
            AppColors.ink,


        borderRadius:
            BorderRadius.circular(22),
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
                10,
          ),


          Text(

            value,


            style:
                AppTypography.titleLarge.copyWith(
              fontWeight:
                  FontWeight.bold,
            ),
          ),


          const SizedBox(
            height:
                4,
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