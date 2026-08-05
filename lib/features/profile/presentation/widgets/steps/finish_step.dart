import 'package:flutter/material.dart';

import '../onboarding_page.dart';

class FinishStep extends StatelessWidget {
  final VoidCallback onFinish;

  const FinishStep({
    super.key,
    required this.onFinish,
  });

  static const _content = Column(
    children: [
      Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: 110,
      ),
      SizedBox(height: 24),
      Text(
        'Seu perfil está completo!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 12),
      Text(
        'A partir de agora você poderá acompanhar seus treinos, evolução, metas e muito mais.',
        textAlign: TextAlign.center,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Tudo pronto! 🎉',
      description:
          'Seu perfil foi configurado. Agora vamos montar sua experiência personalizada dentro do Pulso.',
      buttonText: 'Entrar no Pulso',
      onPressed: onFinish,
      child: _content,
    );
  }
}
