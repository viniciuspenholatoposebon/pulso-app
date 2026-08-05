import 'package:flutter/material.dart';

import 'generator_card.dart';

class DaysSelector extends StatelessWidget {
  const DaysSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final int selected;

  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [2, 3, 4, 5, 6].map((day) {
        return GeneratorCard(
          title: '$day dias por semana',
          subtitle: 'Treinar $day vezes',
          icon: Icons.calendar_month,
          selected: selected == day,
          onTap: () => onChanged(day),
        );
      }).toList(),
    );
  }
}