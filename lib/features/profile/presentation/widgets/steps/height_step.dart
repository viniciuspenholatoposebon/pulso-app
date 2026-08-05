import 'package:flutter/material.dart';

import '../../../../../shared/widgets/pulso_text_field.dart';
import '../onboarding_page.dart';

class HeightStep extends StatefulWidget {
  final double? initialValue;
  final ValueChanged<double> onNext;

  const HeightStep({
    super.key,
    this.initialValue,
    required this.onNext,
  });

  @override
  State<HeightStep> createState() => _HeightStepState();
}

class _HeightStepState extends State<HeightStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.initialValue != null
          ? widget.initialValue!.toStringAsFixed(0)
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

    if (value == null || value < 80 || value > 250) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informe uma altura válida em centímetros.'),
        ),
      );
      return;
    }

    widget.onNext(value);
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Qual é a sua altura?',
      description: 'Digite sua altura em centímetros.',
      buttonText: 'Continuar',
      onPressed: _continue,
      child: Column(
        children: [
          PulsoTextField(
            controller: _controller,
            label: 'Altura (cm)',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          const Text(
            'Exemplo: 170',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
