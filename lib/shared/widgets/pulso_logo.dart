import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Marca PULSO: ícone de pulso + wordmark.
/// Componente reutilizável — usado em telas de autenticação, splash, etc.
class PulsoLogo extends StatelessWidget {
  final double iconSize;
  final double wordmarkFontSize;
  final bool showWordmark;

  const PulsoLogo({
    super.key,
    this.iconSize = 40,
    this.wordmarkFontSize = 20,
    this.showWordmark = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: AppColors.volt,
            borderRadius: BorderRadius.circular(iconSize * 0.28),
          ),
          child: CustomPaint(
            size: Size(iconSize, iconSize),
            painter: _PulseIconPainter(),
          ),
        ),
        if (showWordmark) ...[
          const SizedBox(height: 8),
          Text(
            'PULSO',
            style:
                AppTypography.logoWordmark.copyWith(fontSize: wordmarkFontSize),
          ),
        ],
      ],
    );
  }
}

/// Desenha a linha de pulso (heartbeat) usada no ícone da marca.
class _PulseIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
    final path = Path()
      ..moveTo(w * 0.08, h * 0.5)
      ..lineTo(w * 0.32, h * 0.5)
      ..lineTo(w * 0.42, h * 0.2)
      ..lineTo(w * 0.58, h * 0.8)
      ..lineTo(w * 0.68, h * 0.5)
      ..lineTo(w * 0.92, h * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
