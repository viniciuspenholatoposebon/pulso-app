import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class WeightChartCard extends StatelessWidget {
  const WeightChartCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.volt.withValues(alpha: .18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evolução do Peso',
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Em breve você poderá acompanhar sua evolução ao longo do tempo.',
            style: AppTypography.bodySecondary,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: Center(
              child: Icon(
                Icons.show_chart,
                size: 80,
                color: AppColors.volt.withValues(alpha: .70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
