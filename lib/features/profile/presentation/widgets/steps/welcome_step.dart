import 'package:flutter/material.dart';

import '../onboarding_page.dart';

class WelcomeStep extends StatelessWidget {
  final VoidCallback onStart;

  const WelcomeStep({
    super.key,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Bem-vindo ao Pulso!',
      description:
          'Vamos configurar seu perfil em menos de 2 minutos para criar uma experiência personalizada.',
      buttonText: 'Começar',
      onPressed: onStart,
      child: const Center(
        child: Icon(
          Icons.favorite,
          size: 120,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
