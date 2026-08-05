import 'package:flutter/material.dart';

import 'stat_card.dart';

class StatsGrid extends StatelessWidget {
  final double weight;
  final double bmi;
  final double bmr;
  final double dailyCalories;

  const StatsGrid({
    super.key,
    required this.weight,
    required this.bmi,
    required this.bmr,
    required this.dailyCalories,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.15,
        children: [
          StatCard(
            title: 'Peso',
            value: weight.toStringAsFixed(1),
            unit: 'kg',
            icon: Icons.monitor_weight_outlined,
          ),
          StatCard(
            title: 'IMC',
            value: bmi.toStringAsFixed(1),
            icon: Icons.insights_outlined,
          ),
          StatCard(
            title: 'TMB',
            value: bmr.toStringAsFixed(0),
            unit: 'kcal',
            icon: Icons.local_fire_department_outlined,
          ),
          StatCard(
            title: 'Meta diária',
            value: dailyCalories.toStringAsFixed(0),
            unit: 'kcal',
            icon: Icons.restaurant_menu_outlined,
          ),
        ],
      ),
    );
  }
}
