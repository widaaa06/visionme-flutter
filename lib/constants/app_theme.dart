import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primaryBlue,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
    ),

    scaffoldBackgroundColor:
        AppColors.backgroundLight,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor:
          AppColors.primaryBlue,
      foregroundColor: Colors.white,
    ),
  );
}