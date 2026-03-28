import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryBgDark = Color(0xFF0A0E1A);
  static const Color cardSurfaceDark = Color(0xFF111827);
  static const Color elevatedSurfaceDark = Color(0xFF1E293B);
  static const Color borderColorDark = Color(0xFF2D3F55);
  static const Color cyanPrimeDark = Color(0xFF00D4FF);
  static const Color oceanCyanDark = Color(0xFF00A8CC);
  static const Color skyBlueDark = Color(0xFF7DD3FC);
  static const Color iceWhiteDark = Color(0xFFE0F7FF);
  static const Color streakGreenDark = Color(0xFF22C55E);
  static const Color rewardGoldDark = Color(0xFFF59E0B);
  static const Color alertRedDark = Color(0xFFEF4444);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textTertiaryDark = Color(0xFF64748B);

  static const Color primaryBgLight = Color(0xFFF8FAFC);
  static const Color cardSurfaceLight = Color(0xFFFFFFFF);
  static const Color elevatedSurfaceLight = Color(0xFFF1F5F9);
  static const Color borderColorLight = Color(0xFFE2E8F0);
  static const Color cyanPrimeLight = Color(0xFF00A8CC);
  static const Color oceanCyanLight = Color(0xFF008FB0);
  static const Color skyBlueLight = Color(0xFF38BDF8);
  static const Color iceWhiteLight = Color(0xFFEFF8FF);
  static const Color streakGreenLight = Color(0xFF16A34A);
  static const Color rewardGoldLight = Color(0xFFEAB308);
  static const Color alertRedLight = Color(0xFFDC2626);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF334155);
  static const Color textTertiaryLight = Color(0xFF475569);

  static ColorScheme darkColorScheme() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: cyanPrimeDark,
      onPrimary: textPrimaryDark,
      secondary: oceanCyanDark,
      onSecondary: textPrimaryDark,
      tertiary: skyBlueDark,
      onTertiary: textPrimaryDark,
      error: alertRedDark,
      onError: textPrimaryDark,
      background: primaryBgDark,
      onBackground: textPrimaryDark,
      surface: cardSurfaceDark,
      onSurface: textPrimaryDark,
      surfaceTint: cyanPrimeDark,
      outline: borderColorDark,
      outlineVariant: elevatedSurfaceDark,
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: elevatedSurfaceDark,
      onInverseSurface: textSecondaryDark,
      inversePrimary: oceanCyanDark,
      primaryContainer: elevatedSurfaceDark,
      onPrimaryContainer: textPrimaryDark,
      secondaryContainer: elevatedSurfaceDark,
      onSecondaryContainer: textPrimaryDark,
      tertiaryContainer: elevatedSurfaceDark,
      onTertiaryContainer: textPrimaryDark,
      surfaceContainerHighest: elevatedSurfaceDark,
      surfaceContainerHigh: elevatedSurfaceDark,
      surfaceContainer: cardSurfaceDark,
      surfaceContainerLow: cardSurfaceDark,
      surfaceContainerLowest: primaryBgDark,
      surfaceBright: cardSurfaceDark,
      surfaceDim: primaryBgDark,
    );
  }

  static ColorScheme lightColorScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: cyanPrimeLight,
      onPrimary: Colors.white,
      secondary: oceanCyanLight,
      onSecondary: Colors.white,
      tertiary: skyBlueLight,
      onTertiary: Colors.white,
      error: alertRedLight,
      onError: Colors.white,
      background: primaryBgLight,
      onBackground: textPrimaryLight,
      surface: cardSurfaceLight,
      onSurface: textPrimaryLight,
      surfaceTint: cyanPrimeLight,
      outline: borderColorLight,
      outlineVariant: elevatedSurfaceLight,
      shadow: Colors.black26,
      scrim: Colors.black38,
      inverseSurface: elevatedSurfaceLight,
      onInverseSurface: textSecondaryLight,
      inversePrimary: oceanCyanLight,
      primaryContainer: elevatedSurfaceLight,
      onPrimaryContainer: textPrimaryLight,
      secondaryContainer: elevatedSurfaceLight,
      onSecondaryContainer: textPrimaryLight,
      tertiaryContainer: elevatedSurfaceLight,
      onTertiaryContainer: textPrimaryLight,
      surfaceContainerHighest: elevatedSurfaceLight,
      surfaceContainerHigh: elevatedSurfaceLight,
      surfaceContainer: cardSurfaceLight,
      surfaceContainerLow: cardSurfaceLight,
      surfaceContainerLowest: primaryBgLight,
      surfaceBright: cardSurfaceLight,
      surfaceDim: primaryBgLight,
    );
  }
}

