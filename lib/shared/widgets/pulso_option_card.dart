import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class PulsoOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const PulsoOptionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        scale: selected ? 1.02 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: selected
                ? AppColors.volt.withValues(alpha: .12)
                : AppColors.ink,
            border: Border.all(
              color: selected
                  ? AppColors.volt
                  : Colors.white.withValues(alpha: .08),
              width: 2,
            ),
            boxShadow: [
              if (selected)
                BoxShadow(
                  color: AppColors.volt.withValues(alpha: .18),
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? AppColors.volt
                            : Colors.white.withValues(alpha: .06),
                      ),
                      child: Icon(
                        icon,
                        size: 28,
                        color: selected ? AppColors.ink : AppColors.paper,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        title,
                        style: AppTypography.body.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: selected
                          ? Container(
                              key: const ValueKey(true),
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.volt,
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 18,
                                color: AppColors.ink,
                              ),
                            )
                          : Container(
                              key: const ValueKey(false),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white24,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
