import 'package:flutter/material.dart';

import '../../core/theme/app_typography.dart';

/// Checkbox com rótulo clicável — usado em "Lembrar de mim".
class PulsoCheckboxLabel extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool?> onChanged;

  const PulsoCheckboxLabel({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 8),
          Text(label, style: AppTypography.bodySecondary),
        ],
      ),
    );
  }
}
