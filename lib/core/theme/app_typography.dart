import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Escala tipográfica oficial do PULSO.
class AppTypography {
  AppTypography._();

  // =========================
  // DISPLAY
  // =========================

  static TextStyle get logoWordmark => GoogleFonts.bigShouldersDisplay(
        fontWeight: FontWeight.w900,
        fontSize: 34,
        letterSpacing: .5,
        color: AppColors.paper,
        height: 1,
      );

  static TextStyle get displayLarge => GoogleFonts.bigShouldersDisplay(
        fontWeight: FontWeight.w900,
        fontSize: 40,
        color: AppColors.paper,
      );

  static TextStyle get displayMedium => GoogleFonts.bigShouldersDisplay(
        fontWeight: FontWeight.w800,
        fontSize: 34,
        color: AppColors.paper,
      );

  // =========================
  // HEADLINES
  // =========================

  static TextStyle get headline => GoogleFonts.bigShouldersDisplay(
        fontWeight: FontWeight.w900,
        fontSize: 26,
        color: AppColors.paper,
      );

  static TextStyle get headlineMedium => GoogleFonts.bigShouldersDisplay(
        fontWeight: FontWeight.w800,
        fontSize: 24,
        color: AppColors.paper,
      );

  static TextStyle get headlineSmall => GoogleFonts.bigShouldersDisplay(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: AppColors.paper,
      );

  // =========================
  // TITLES
  // =========================

  static TextStyle get titleLarge => GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: AppColors.paper,
      );

  static TextStyle get titleMedium => GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.paper,
      );

  // =========================
  // SUBTITLE
  // =========================

  static TextStyle get subtitle => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: AppColors.mist,
        letterSpacing: .2,
      );

  // =========================
  // BODY
  // =========================

  static TextStyle get body => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.paper,
      );

  static TextStyle get bodySecondary => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: AppColors.mist,
      );

  // =========================
  // BUTTON
  // =========================

  static TextStyle get button => GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: AppColors.ink,
      );

  // =========================
  // MONO
  // =========================

  static TextStyle get mono => GoogleFonts.jetBrainsMono(
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: AppColors.paper,
      );
}
