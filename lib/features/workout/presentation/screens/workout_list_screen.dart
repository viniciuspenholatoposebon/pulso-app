import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/workout_controller.dart';
import '../widgets/workout_list_card.dart';

class WorkoutListScreen extends ConsumerWidget {
  const WorkoutListScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final workouts = ref.watch(
      workoutControllerProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meus Treinos',
        ),
      ),
      body: workouts.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, _) {
          return Center(
            child: Text(
              error.toString(),
            ),
          );
        },
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text(
                'Você ainda não possui treinos.',
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              return ref
                  .read(
                    workoutControllerProvider.notifier,
                  )
                  .refresh();
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 24,
              ),
              itemCount: items.length,
              itemBuilder: (
                context,
                index,
              ) {
                final workout = items[index];

                return WorkoutListCard(
                  workout: workout,
                );
              },
            ),
          );
        },
      ),
    );
  }
}