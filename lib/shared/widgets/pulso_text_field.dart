import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Campo de texto padrão do Design System PULSO.
/// Suporta modo senha com alternância de visibilidade (mostrar/ocultar).
class PulsoTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  const PulsoTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textInputAction = TextInputAction.next,
  });

  @override
  State<PulsoTextField> createState() => _PulsoTextFieldState();
}

class _PulsoTextFieldState extends State<PulsoTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscure : false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppTypography.body,
      cursorColor: AppColors.volt,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.mist,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
                tooltip: _obscure ? 'Mostrar senha' : 'Ocultar senha',
              )
            : null,
      ),
    );
  }
}
