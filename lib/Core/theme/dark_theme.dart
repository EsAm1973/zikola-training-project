import 'package:flutter/material.dart';
import 'package:zikola_training_project/Core/utils/app_colors.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.darkPrimary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  fontFamily: 'Montserrat',
  colorScheme: const ColorScheme.dark(
    primary: AppColors.darkPrimary,
    secondary: AppColors.secondary,
    surface: AppColors.darkSurface,
    error: AppColors.error,
    onPrimary: AppColors.onDarkPrimary,
    onSecondary: AppColors.onSecondary,
    onSurface: AppColors.onDarkSurface,
    onError: AppColors.onError,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    foregroundColor: AppColors.onDarkBackground,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.onDarkBackground),
    titleTextStyle: TextStyle(
      color: AppColors.onDarkBackground,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.onDarkPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.darkPrimary,
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface.withOpacity(0.7),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: AppColors.darkPrimary, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    hintStyle: TextStyle(color: AppColors.onDarkSurface.withOpacity(0.5)),
  ),
  cardTheme: CardThemeData(
    elevation: 4,
    color: AppColors.darkSurface,
    shadowColor: AppColors.onBackground.withOpacity(0.1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),
  dividerColor: AppColors.grey4.withOpacity(0.5),
  disabledColor: AppColors.onDarkSurface.withOpacity(0.5),
);
