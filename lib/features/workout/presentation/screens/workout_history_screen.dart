import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/workout_history_controller.dart';
import '../widgets/workout_history_card.dart';


class WorkoutHistoryScreen
    extends ConsumerWidget {

  const WorkoutHistoryScreen({
    super.key,
  });


  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {

    final history =
        ref.watch(
          workoutHistoryControllerProvider,
        );


    return Scaffold(

      appBar: AppBar(
        title:
            const Text(
          'Histórico',
        ),
      ),


      body:
          history.when(

        loading: () {

          return const Center(
            child:
                CircularProgressIndicator(),
          );

        },


        error: (
          error,
          _,
        ) {

          return Center(
            child:
                Text(
              error.toString(),
            ),
          );

        },


        data: (
          sessions,
        ) {

          if (sessions.isEmpty) {

            return const Center(
              child:
                  Text(
                'Nenhum treino concluído ainda.',
              ),
            );

          }


          return RefreshIndicator(

            onRefresh: () async {

              ref.invalidate(
                workoutHistoryControllerProvider,
              );

            },


            child:
                ListView.builder(

              padding:
                  const EdgeInsets.all(
                20,
              ),


              itemCount:
                  sessions.length,


              itemBuilder: (
                context,
                index,
              ) {

                final session =
                    sessions[index];


                return WorkoutHistoryCard(
                  session:
                      session,
                );

              },
            ),
          );
        },
      ),
    );
  }
}