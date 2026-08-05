import 'package:flutter/material.dart';

import '../../../../shared/widgets/pulso_primary_button.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;
  final String buttonText;
  final VoidCallback onPressed;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.child,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.62,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 32),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            child: PulsoPrimaryButton(
              label: buttonText,
              onPressed: onPressed,
            ),
          ),
        ),
      ],
    );
  }
}
