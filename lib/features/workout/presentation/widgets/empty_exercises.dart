import 'package:flutter/material.dart';

class EmptyExercises extends StatelessWidget {
  const EmptyExercises({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Nenhum exercício encontrado.',
      ),
    );
  }
}