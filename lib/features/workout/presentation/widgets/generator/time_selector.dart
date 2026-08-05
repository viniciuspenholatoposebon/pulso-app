import 'package:flutter/material.dart';

import 'generator_card.dart';

class TimeSelector extends StatelessWidget {
  const TimeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final int selected;

  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [30, 45, 60, 75, 90].map((time) {
        return GeneratorCard(
          title: '$time minutos',
          subtitle: 'Tempo disponível por treino',
          icon: Icons.timer_outlined,
          selected: selected == time,
          onTap: () => onChanged(time),
        );
      }).toList(),
    );
  }
}