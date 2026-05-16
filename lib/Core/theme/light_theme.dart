import 'package:flutter/material.dart';
import 'package:zikola_training_project/Core/utils/app_colors.dart';
import 'package:zikola_training_project/Core/utils/app_text_styles.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  fontFamily: 'Montserrat',
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surface,
    error: AppColors.error,
    onPrimary: AppColors.onPrimary,
    onSecondary: AppColors.onSecondary,
    onSurface: AppColors.onSurface,
    onError: AppColors.onError,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.onBackground,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.onBackground),
    titleTextStyle: TextStyle(
      color: AppColors.onBackground,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.primary),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface.withOpacity(0.5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    hintStyle: TextStyle(color: AppColors.onSurface.withOpacity(0.5)),
  ),
  cardTheme: CardThemeData(
    elevation: 2,
    color: AppColors.surface,
    shadowColor: AppColors.onBackground.withOpacity(0.06),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),
  dividerColor: AppColors.grey4.withOpacity(0.6),
  disabledColor: AppColors.onSurface.withOpacity(0.5),
);
