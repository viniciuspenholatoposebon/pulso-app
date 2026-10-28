import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/training_goal.dart';
import '../../data/models/training_level.dart';
import '../controllers/workout_controller.dart';
import '../widgets/generator/days_selector.dart';
import '../widgets/generator/goal_selector.dart';
import '../widgets/generator/level_selector.dart';
import '../widgets/generator/time_selector.dart';


class TrainingGeneratorScreen
    extends ConsumerStatefulWidget {

  const TrainingGeneratorScreen({
    super.key,
  });


  @override
  ConsumerState<TrainingGeneratorScreen> createState() =>
      _TrainingGeneratorScreenState();
}



class _TrainingGeneratorScreenState
    extends ConsumerState<TrainingGeneratorScreen> {


  TrainingGoal _goal =
      TrainingGoal.hypertrophy;


  TrainingLevel _level =
      TrainingLevel.beginner;


  int _days = 3;


  int _minutes = 60;



  @override
  Widget build(BuildContext context) {

    final workouts =
        ref.watch(
          workoutControllerProvider,
        );


    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Gerador Inteligente',
        ),
      ),


      body: SafeArea(

        child: ListView(

          padding:
              const EdgeInsets.all(20),


          children: [

            const Text(
              'Qual é o seu objetivo?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(
              height: 18,
            ),


            GoalSelector(
              selected: _goal,
              onChanged: (goal) {

                setState(() {
                  _goal = goal;
                });

              },
            ),



            const SizedBox(
              height: 30,
            ),



            const Text(
              'Qual é o seu nível?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),



            const SizedBox(
              height: 18,
            ),



            LevelSelector(
              selected: _level,
              onChanged: (level) {

                setState(() {
                  _level = level;
                });

              },
            ),




            const SizedBox(
              height: 30,
            ),



            const Text(
              'Quantos dias por semana?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),



            const SizedBox(
              height: 18,
            ),



            DaysSelector(
              selected: _days,
              onChanged: (days) {

                setState(() {
                  _days = days;
                });

              },
            ),




            const SizedBox(
              height: 30,
            ),



            const Text(
              'Tempo disponível',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),



            const SizedBox(
              height: 18,
            ),



            TimeSelector(
              selected: _minutes,
              onChanged: (minutes) {

                setState(() {
                  _minutes = minutes;
                });

              },
            ),




            const SizedBox(
              height: 40,
            ),




            FilledButton(

              onPressed: () async {

                await ref
                    .read(
                      workoutControllerProvider
                          .notifier,
                    )
                    .generateWorkout(

                      goal: _goal,

                      level: _level,

                      trainingDays: _days,

                    );

              },


              child: const Padding(

                padding:
                    EdgeInsets.symmetric(
                  vertical: 18,
                ),


                child: Text(
                  'GERAR MEU TREINO',
                ),

              ),

            ),





            const SizedBox(
              height: 40,
            ),






            workouts.when(

              loading: () =>
                  const Center(
                    child:
                        CircularProgressIndicator(),
                  ),



              error: (
                error,
                _,
              ) =>
                  Text(
                    error.toString(),
                  ),




              data: (
                items,
              ) {



                final activeWorkouts =
                    items
                        .where(
                          (workout) =>
                              workout.isActive,
                        )
                        .toList();




                if (activeWorkouts.isEmpty) {

                  return const SizedBox();

                }





                return Column(

                  children:

                      activeWorkouts.map(
                    (
                      workout,
                    ) {


                      return Card(

                        child:
                            ExpansionTile(


                          title:
                              Text(
                            workout.name,
                          ),



                          subtitle:
                              Text(
                            '${workout.weekDays.join(', ')} • ${workout.description}',
                          ),



                          children:

                              workout.exercises
                                  .map(

                            (
                              exercise,
                            ) => ListTile(

                              leading:
                                  const Icon(
                                Icons.fitness_center,
                              ),


                              title:
                                  Text(
                                exercise.exerciseId,
                              ),


                              subtitle:
                                  Text(
                                '${exercise.sets} séries • ${exercise.minReps}-${exercise.maxReps} reps',
                              ),

                            ),

                          )
                                  .toList(),

                        ),

                      );


                    },

                  ).toList(),

                );

              },

            ),

          ],

        ),

      ),

    );

  }

}