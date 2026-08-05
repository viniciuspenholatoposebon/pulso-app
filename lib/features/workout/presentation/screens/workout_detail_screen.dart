import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/workout.dart';
import '../controllers/workout_execution_controller.dart';
import 'workout_execution_screen.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  const WorkoutDetailScreen({
    super.key,
    required this.workout,
  });

  final Workout workout;

  void _startWorkout(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref
        .read(
          workoutExecutionControllerProvider
              .notifier,
        )
        .startWorkout(
          workout,
        );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            const WorkoutExecutionScreen(),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          workout.name,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              workout.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              workout.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                _InfoCard(
                  icon: Icons.timer,
                  label:
                      '${workout.estimatedDuration} min',
                ),
                const SizedBox(width: 12),
                _InfoCard(
                  icon: Icons.fitness_center,
                  label:
                      '${workout.exercises.length} exercícios',
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Exercícios',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            ...workout.exercises.map(
              (exercise) {
                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: ListTile(
                    leading:
                        const CircleAvatar(
                      child: Icon(
                        Icons.fitness_center,
                      ),
                    ),
                    title: Text(
                      exercise.exerciseId,
                    ),
                    subtitle: Text(
                      '${exercise.sets} séries • ${exercise.minReps}-${exercise.maxReps} reps',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              onPressed: () {
                _startWorkout(
                  context,
                  ref,
                );
              },
              icon: const Icon(
                Icons.play_arrow,
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Text(
                  'INICIAR TREINO',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(16),
          color: Colors.black12,
        ),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}