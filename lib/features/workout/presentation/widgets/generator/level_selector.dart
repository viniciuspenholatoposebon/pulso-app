import 'package:flutter/material.dart';

import '../../../data/models/training_level.dart';
import 'generator_card.dart';

class LevelSelector extends StatelessWidget {
  const LevelSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final TrainingLevel selected;

  final ValueChanged<TrainingLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: TrainingLevel.values.map((level) {
        return GeneratorCard(
          title: level.title,
          subtitle: 'Nível de experiência',
          icon: Icons.workspace_premium,
          selected: selected == level,
          onTap: () => onChanged(level),
        );
      }).toList(),
    );
  }
}