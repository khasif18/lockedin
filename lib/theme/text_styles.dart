import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle _baseTextStyle({required Color color}) {
    return GoogleFonts.poppins(
      color: color,
      height: 1.25,
    );
  }

  static TextTheme darkTextTheme() {
    return TextTheme(
      displayLarge: _baseTextStyle(color: AppColors.textPrimaryDark).copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      displayMedium: _baseTextStyle(color: AppColors.textPrimaryDark).copyWith(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
      ),
      displaySmall: _baseTextStyle(color: AppColors.textPrimaryDark).copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: _baseTextStyle(color: AppColors.textSecondaryDark).copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: _baseTextStyle(color: AppColors.textSecondaryDark).copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: _baseTextStyle(color: AppColors.textTertiaryDark).copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
    );
  }

  static TextTheme lightTextTheme() {
    return TextTheme(
      displayLarge: _baseTextStyle(color: AppColors.textPrimaryLight).copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      displayMedium: _baseTextStyle(color: AppColors.textPrimaryLight).copyWith(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
      ),
      displaySmall: _baseTextStyle(color: AppColors.textPrimaryLight).copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: _baseTextStyle(color: AppColors.textSecondaryLight).copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: _baseTextStyle(color: AppColors.textSecondaryLight).copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: _baseTextStyle(color: AppColors.textTertiaryLight).copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
    );
  }
}

