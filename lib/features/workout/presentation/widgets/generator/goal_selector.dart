import 'package:flutter/material.dart';

import '../../../data/models/training_goal.dart';
import 'generator_card.dart';

class GoalSelector extends StatelessWidget {
  const GoalSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final TrainingGoal selected;

  final ValueChanged<TrainingGoal> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: TrainingGoal.values.map((goal) {
        return GeneratorCard(
          title: goal.title,
          subtitle: goal.description,
          icon: Icons.fitness_center,
          selected: goal == selected,
          onTap: () => onChanged(goal),
        );
      }).toList(),
    );
  }
}