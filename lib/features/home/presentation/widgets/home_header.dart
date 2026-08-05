import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class HomeHeader extends StatelessWidget {
  final String userName;

  const HomeHeader({
    super.key,
    required this.userName,
  });

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Bom dia';
    }

    if (hour < 18) {
      return 'Boa tarde';
    }

    return 'Boa noite';
  }

  @override
  Widget build(BuildContext context) {
    final date = DateFormat(
      "EEEE, d 'de' MMMM",
      'pt_BR',
    ).format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_greeting()}, $userName 👋',
            style: AppTypography.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            date[0].toUpperCase() + date.substring(1),
            style: AppTypography.bodySecondary.copyWith(
              color: AppColors.paper.withValues(alpha: .70),
            ),
          ),
        ],
      ),
    );
  }
}
