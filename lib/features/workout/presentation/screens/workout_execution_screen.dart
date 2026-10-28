import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/workout_execution_controller.dart';
import '../widgets/execution/exercise_execution_card.dart';
import 'workout_summary_screen.dart';



class WorkoutExecutionScreen
    extends ConsumerStatefulWidget {

  const WorkoutExecutionScreen({
    super.key,
  });


  @override
  ConsumerState<WorkoutExecutionScreen> createState() =>
      _WorkoutExecutionScreenState();
}





class _WorkoutExecutionScreenState
    extends ConsumerState<WorkoutExecutionScreen> {


  int exerciseIndex = 0;

  int setIndex = 0;

  double weight = 0;

  int reps = 0;





  @override
  Widget build(
    BuildContext context,
  ) {


    final session =
        ref.watch(
          workoutExecutionControllerProvider,
        );



    if (session == null) {

      return Scaffold(

        appBar: AppBar(

          title:
              const Text(
            'Treino',
          ),

        ),


        body:
            const Center(

          child:
              Text(
            'Nenhum treino iniciado.',
          ),

        ),

      );

    }





    final exercise =
        session.exercises[exerciseIndex];



    final currentSet =
        exercise.sets[setIndex];







    return Scaffold(

      appBar: AppBar(

        title:
            const Text(
          'Treino em andamento',
        ),

      ),





      body: SafeArea(

        child: Padding(

          padding:
              const EdgeInsets.all(20),



          child: Column(

            children: [



              LinearProgressIndicator(

                value:
                    (exerciseIndex + 1) /
                        session.exercises.length,

              ),




              const SizedBox(

                height:
                    20,

              ),






              Expanded(

                child:
                    SingleChildScrollView(


                  child:
                      ExerciseExecutionCard(


                    exercise:
                        exercise,



                    currentSet:
                        setIndex,



                    onChangeWeight:
                        (value) {


                      weight =
                          value;


                    },



                    onChangeReps:
                        (value) {


                      reps =
                          value;


                    },





                    onCompleteSet:
                        () async {



                      ref
                          .read(
                            workoutExecutionControllerProvider
                                .notifier,
                          )
                          .completeSet(

                            exerciseIndex:
                                exerciseIndex,

                            setIndex:
                                setIndex,

                            weight:
                                weight == 0
                                    ? currentSet.weight
                                    : weight,

                            reps:
                                reps == 0
                                    ? currentSet.reps
                                    : reps,

                          );







                      await Future.delayed(

                        const Duration(

                          milliseconds:
                              300,

                        ),

                      );








                      if (setIndex + 1 <
                          exercise.sets.length) {


                        setState(() {


                          setIndex++;


                        });


                        return;


                      }









                      if (exerciseIndex + 1 <
                          session.exercises.length) {


                        setState(() {


                          exerciseIndex++;


                          setIndex = 0;


                          weight = 0;


                          reps = 0;



                        });


                        return;


                      }









                      await ref
                          .read(
                            workoutExecutionControllerProvider
                                .notifier,
                          )
                          .finishWorkout();







                      final finishedSession =
                          ref.read(
                            workoutExecutionControllerProvider,
                          );








                      if (!context.mounted ||
                          finishedSession == null) {


                        return;


                      }








                      await Navigator.pushReplacement(


                        context,



                        MaterialPageRoute(



                          builder:
                              (_) =>
                                  WorkoutSummaryScreen(

                            session:
                                finishedSession,

                          ),


                        ),



                      );




                    },



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