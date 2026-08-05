import 'package:flutter/material.dart';

import '../../data/models/exercise.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  const ExerciseDetailsScreen({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(
            Icons.fitness_center,
            size: 90,
          ),

          const SizedBox(height: 24),

          Text(
            exercise.name,
            style: Theme.of(context)
                .textTheme
                .headlineMedium,
          ),

          const SizedBox(height: 24),

          ListTile(
            leading: const Icon(Icons.groups),
            title: const Text('Grupo Muscular'),
            subtitle: Text(
              exercise.muscleGroupId,
            ),
          ),

          ListTile(
            leading: const Icon(Icons.handyman),
            title: const Text('Equipamento'),
            subtitle: Text(
              exercise.equipmentId,
            ),
          ),

          ListTile(
            leading: const Icon(Icons.trending_up),
            title: const Text('Nível'),
            subtitle: Text(
              exercise.level,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Execução',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            exercise.instructions,
          ),
        ],
      ),
    );
  }
}