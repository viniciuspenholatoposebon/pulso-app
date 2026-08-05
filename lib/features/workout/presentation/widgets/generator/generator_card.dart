import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';

class GeneratorCard extends StatelessWidget {
  const GeneratorCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 180,
      ),
      margin: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected
                    ? AppColors.volt
                    : AppColors.divider,
                width: selected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: selected
                      ? AppColors.volt
                      : AppColors.ink,
                  child: Icon(
                    icon,
                    color: selected
                        ? AppColors.ink
                        : AppColors.paper,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.body.copyWith(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTypography.bodySecondary,
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 180,
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check_circle,
                          color: AppColors.volt,
                          key: ValueKey(1),
                        )
                      : const Icon(
                          Icons.circle_outlined,
                          key: ValueKey(2),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}