import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../data/models/exercise_execution.dart';


class ExerciseExecutionCard extends StatelessWidget {
  const ExerciseExecutionCard({
    super.key,
    required this.exercise,
    required this.currentSet,
    required this.onCompleteSet,
    required this.onChangeWeight,
    required this.onChangeReps,
  });


  final ExerciseExecution exercise;

  final int currentSet;

  final VoidCallback onCompleteSet;

  final ValueChanged<double> onChangeWeight;

  final ValueChanged<int> onChangeReps;



  @override
  Widget build(
    BuildContext context,
  ) {

    final set =
        exercise.sets[currentSet];


    return Container(

      padding:
          const EdgeInsets.all(24),


      decoration:
          BoxDecoration(

        color:
            AppColors.ink,


        borderRadius:
            BorderRadius.circular(32),


        border: Border.all(
          color:
              AppColors.volt.withValues(
            alpha: .20,
          ),
        ),
      ),


      child:
          Column(

        children: [


          Text(

            exercise.exerciseName,


            textAlign:
                TextAlign.center,


            style:
                AppTypography.headlineMedium.copyWith(
              fontWeight:
                  FontWeight.bold,
            ),
          ),



          const SizedBox(
            height:
                12,
          ),



          Container(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 8,
            ),


            decoration:
                BoxDecoration(

              borderRadius:
                  BorderRadius.circular(30),


              border:
                  Border.all(
                color:
                    Colors.white24,
              ),
            ),


            child:
                Text(

              'Série ${currentSet + 1}/${exercise.sets.length}  •  Descanso ${exercise.restSeconds}s',


              style:
                  AppTypography.bodySecondary,
            ),
          ),



          const SizedBox(
            height:
                30,
          ),



          Container(

            height:
                220,


            width:
                double.infinity,


            decoration:
                BoxDecoration(

              color:
                  Colors.white.withValues(
                alpha: .05,
              ),


              borderRadius:
                  BorderRadius.circular(28),
            ),


            child:
                const Center(

              child:
                  Icon(
                Icons.fitness_center,
                size:
                    80,
                color:
                    AppColors.volt,
              ),
            ),
          ),



          const SizedBox(
            height:
                30,
          ),



          Row(

            children: [


              Expanded(
                child:
                    _ValueBox(
                  title:
                      'Repetições',

                  value:
                      '${set.reps}',

                  onTap: () {},
                ),
              ),



              const SizedBox(
                width:
                    16,
              ),



              Expanded(
                child:
                    _ValueBox(
                  title:
                      'Carga',

                  value:
                      '${set.weight} kg',

                  onTap: () {},
                ),
              ),
            ],
          ),



          const SizedBox(
            height:
                24,
          ),



          SizedBox(

            width:
                double.infinity,


            child:
                FilledButton(

              onPressed:
                  set.completed
                      ? null
                      : onCompleteSet,


              child:
                  Padding(

                padding:
                    const EdgeInsets.symmetric(
                  vertical:
                      16,
                ),


                child:
                    Text(

                  set.completed
                      ? 'REALIZADO'
                      : 'CONCLUIR SÉRIE',

                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class _ValueBox extends StatelessWidget {

  const _ValueBox({
    required this.title,
    required this.value,
    required this.onTap,
  });


  final String title;

  final String value;

  final VoidCallback onTap;



  @override
  Widget build(
    BuildContext context,
  ) {

    return InkWell(

      onTap:
          onTap,


      borderRadius:
          BorderRadius.circular(20),


      child:
          Container(

        padding:
            const EdgeInsets.all(18),


        decoration:
            BoxDecoration(

          color:
              Colors.white.withValues(
            alpha: .06,
          ),


          borderRadius:
              BorderRadius.circular(20),
        ),


        child:
            Column(

          children: [


            Text(
              title,

              style:
                  AppTypography.bodySecondary,
            ),



            const SizedBox(
              height:
                  8,
            ),



            Text(

              value,


              style:
                  AppTypography.titleLarge.copyWith(
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}