import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Tema global do app, baseado em Material Design 3. DEFINITIVO.
/// Centraliza todos os estilos de componentes para garantir
/// consistência do Design System em todas as telas.
class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.volt,
      brightness: Brightness.dark,
      primary: AppColors.volt,
      onPrimary: AppColors.ink,
      secondary: AppColors.signal,
      surface: AppColors.surface,
      onSurface: AppColors.paper,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.ink,
      colorScheme: colorScheme,
      textTheme: TextTheme(
        headlineSmall: AppTypography.headline,
        bodyMedium: AppTypography.body,
        bodySmall: AppTypography.subtitle,
        labelLarge: AppTypography.button,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.volt, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.signal, width: 1),
        ),
        hintStyle: AppTypography.bodySecondary,
        labelStyle: AppTypography.bodySecondary,
        errorStyle:
            AppTypography.bodySecondary.copyWith(color: AppColors.signal),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.volt;
          return Colors.transparent;
        }),
        checkColor: const WidgetStatePropertyAll(AppColors.ink),
        side: const BorderSide(color: AppColors.mist, width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.volt,
          foregroundColor: AppColors.ink,
          disabledBackgroundColor: AppColors.volt.withValues(alpha: 0.5),
          minimumSize: const Size.fromHeight(52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: AppTypography.button,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.paper,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: AppColors.inputBorder),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: AppTypography.body,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.mist,
          textStyle: AppTypography.bodySecondary,
        ),
      ),
    );
  }
}
