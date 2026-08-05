import 'package:flutter/material.dart';

import '../../../data/enums/gender.dart';
import '../../../../../shared/widgets/pulso_option_card.dart';
import '../onboarding_page.dart';

class GenderStep extends StatefulWidget {
  final Gender? initialValue;
  final ValueChanged<Gender> onNext;

  const GenderStep({
    super.key,
    this.initialValue,
    required this.onNext,
  });

  @override
  State<GenderStep> createState() => _GenderStepState();
}

class _GenderStepState extends State<GenderStep> {
  Gender? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  void _continue() {
    if (_selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione uma opção.'),
        ),
      );
      return;
    }

    widget.onNext(_selected!);
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Qual é o seu sexo?',
      description:
          'Utilizamos essa informação para personalizar seus cálculos.',
      buttonText: 'Continuar',
      onPressed: _continue,
      child: Column(
        children: [
          PulsoOptionCard(
            title: 'Masculino',
            icon: Icons.male,
            selected: _selected == Gender.male,
            onTap: () {
              setState(() {
                _selected = Gender.male;
              });
            },
          ),
          PulsoOptionCard(
            title: 'Feminino',
            icon: Icons.female,
            selected: _selected == Gender.female,
            onTap: () {
              setState(() {
                _selected = Gender.female;
              });
            },
          ),
        ],
      ),
    );
  }
}
