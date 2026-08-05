import 'package:flutter/material.dart';

/// Botão de login social (Google/Apple).
/// Apenas interface — sem integração de autenticação.
class PulsoSocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback? onPressed;

  const PulsoSocialButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }
}
