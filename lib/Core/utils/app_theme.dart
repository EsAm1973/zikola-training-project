import 'package:flutter/material.dart';
import 'package:zikola_training_project/Core/theme/dark_theme.dart';
import 'package:zikola_training_project/Core/theme/light_theme.dart';

abstract class AppTheme {
  static ThemeData get getLightTheme => lightTheme;
  static ThemeData get getDarkTheme => darkTheme;
}
