import 'package:flutter/material.dart';

import '../../../../../shared/widgets/pulso_text_field.dart';
import '../onboarding_page.dart';

class NicknameStep extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onNext;

  const NicknameStep({
    super.key,
    required this.initialValue,
    required this.onNext,
  });

  @override
  State<NicknameStep> createState() => _NicknameStepState();
}

class _NicknameStepState extends State<NicknameStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.initialValue,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _continue() {
    final nickname = _controller.text.trim();

    if (nickname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite como você gostaria de ser chamado.',
          ),
        ),
      );
      return;
    }

    widget.onNext(nickname);
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Como você gostaria de ser chamado?',
      description: 'Esse será o nome exibido em todo o aplicativo.',
      buttonText: 'Continuar',
      onPressed: _continue,
      child: PulsoTextField(
        controller: _controller,
        label: 'Seu nome',
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
