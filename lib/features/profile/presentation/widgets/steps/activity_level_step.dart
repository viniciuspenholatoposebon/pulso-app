import 'package:flutter/material.dart';

import '../../../data/enums/activity_level.dart';
import '../../../../../shared/widgets/pulso_option_card.dart';
import '../onboarding_page.dart';

class ActivityLevelStep extends StatefulWidget {
  final ActivityLevel? initialValue;
  final ValueChanged<ActivityLevel> onNext;

  const ActivityLevelStep({
    super.key,
    this.initialValue,
    required this.onNext,
  });

  @override
  State<ActivityLevelStep> createState() => _ActivityLevelStepState();
}

class _ActivityLevelStepState extends State<ActivityLevelStep> {
  ActivityLevel? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  void _continue() {
    if (_selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione um nível de atividade.'),
        ),
      );
      return;
    }

    widget.onNext(_selected!);
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Qual é o seu nível de atividade?',
      description: 'Isso nos ajuda a calcular seu gasto calórico diário.',
      buttonText: 'Continuar',
      onPressed: _continue,
      child: Column(
        children: [
          PulsoOptionCard(
            title: 'Sedentário',
            icon: Icons.weekend,
            selected: _selected == ActivityLevel.sedentary,
            onTap: () {
              setState(() {
                _selected = ActivityLevel.sedentary;
              });
            },
          ),
          PulsoOptionCard(
            title: 'Levemente ativo',
            icon: Icons.directions_walk,
            selected: _selected == ActivityLevel.lightlyActive,
            onTap: () {
              setState(() {
                _selected = ActivityLevel.lightlyActive;
              });
            },
          ),
          PulsoOptionCard(
            title: 'Moderadamente ativo',
            icon: Icons.directions_run,
            selected: _selected == ActivityLevel.moderatelyActive,
            onTap: () {
              setState(() {
                _selected = ActivityLevel.moderatelyActive;
              });
            },
          ),
          PulsoOptionCard(
            title: 'Muito ativo',
            icon: Icons.fitness_center,
            selected: _selected == ActivityLevel.veryActive,
            onTap: () {
              setState(() {
                _selected = ActivityLevel.veryActive;
              });
            },
          ),
          PulsoOptionCard(
            title: 'Extremamente ativo',
            icon: Icons.bolt,
            selected: _selected == ActivityLevel.extremelyActive,
            onTap: () {
              setState(() {
                _selected = ActivityLevel.extremelyActive;
              });
            },
          ),
        ],
      ),
    );
  }
}
