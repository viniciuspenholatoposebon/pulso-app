import 'package:flutter/material.dart';

import '../../../../../shared/widgets/pulso_text_field.dart';
import '../onboarding_page.dart';

class WeightStep extends StatefulWidget {
  final double? initialValue;
  final ValueChanged<double> onNext;

  const WeightStep({
    super.key,
    this.initialValue,
    required this.onNext,
  });

  @override
  State<WeightStep> createState() => _WeightStepState();
}

class _WeightStepState extends State<WeightStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.initialValue != null
          ? widget.initialValue!.toStringAsFixed(1)
          : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _continue() {
    final value = double.tryParse(
      _controller.text.replaceAll(',', '.'),
    );

    if (value == null || value < 20 || value > 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Informe um peso válido.',
          ),
        ),
      );
      return;
    }

    widget.onNext(value);
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Qual é o seu peso?',
      description: 'Digite seu peso atual em quilogramas.',
      buttonText: 'Continuar',
      onPressed: _continue,
      child: Column(
        children: [
          PulsoTextField(
            controller: _controller,
            label: 'Peso (kg)',
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Exemplo: 72,5',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
