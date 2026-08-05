import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? unit;
  final IconData icon;
  final Color? color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.unit,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = color ?? AppColors.volt;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: accentColor.withValues(alpha: .18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: .12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: accentColor,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: AppTypography.bodySecondary,
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: AppTypography.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (unit != null)
                  TextSpan(
                    text: ' $unit',
                    style: AppTypography.body.copyWith(
                      color: Colors.white70,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
