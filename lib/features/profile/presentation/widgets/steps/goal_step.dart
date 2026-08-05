import 'package:flutter/material.dart';

import '../../../data/enums/goal.dart';
import '../../../../../shared/widgets/pulso_option_card.dart';
import '../onboarding_page.dart';

class GoalStep extends StatefulWidget {
  final List<Goal> initialValue;
  final ValueChanged<List<Goal>> onNext;

  const GoalStep({
    super.key,
    this.initialValue = const [],
    required this.onNext,
  });

  @override
  State<GoalStep> createState() => _GoalStepState();
}

class _GoalStepState extends State<GoalStep> {
  late List<Goal> _selectedGoals;

  @override
  void initState() {
    super.initState();
    _selectedGoals = [...widget.initialValue];
  }

  void _toggle(Goal goal) {
    setState(() {
      if (_selectedGoals.contains(goal)) {
        _selectedGoals.remove(goal);
      } else {
        _selectedGoals.add(goal);
      }
    });
  }

  void _continue() {
    if (_selectedGoals.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione pelo menos um objetivo.',
          ),
        ),
      );
      return;
    }

    widget.onNext(_selectedGoals);
  }

  Widget _card(
    Goal goal,
    String title,
    IconData icon,
  ) {
    return PulsoOptionCard(
      title: title,
      icon: icon,
      selected: _selectedGoals.contains(goal),
      onTap: () => _toggle(goal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Quais são seus objetivos?',
      description:
          'Você pode escolher mais de uma opção. Isso ajuda o Pulso a montar um plano mais personalizado.',
      buttonText: 'Continuar',
      onPressed: _continue,
      child: Column(
        children: [
          _card(
            Goal.loseWeight,
            'Perder peso',
            Icons.local_fire_department,
          ),
          _card(
            Goal.bodyRecomposition,
            'Recomposição corporal',
            Icons.autorenew,
          ),
          _card(
            Goal.gainMuscle,
            'Ganhar massa muscular',
            Icons.fitness_center,
          ),
          _card(
            Goal.improveHealth,
            'Melhorar a saúde',
            Icons.favorite,
          ),
          _card(
            Goal.improvePerformance,
            'Melhorar performance',
            Icons.emoji_events,
          ),
        ],
      ),
    );
  }
}
