import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/app_fonts.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    fontFamily: AppFonts.cairoFamily,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.whiteColor,
      surfaceTintColor: Colors.transparent,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.darkColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: AppColors.whiteColor,
      type: BottomNavigationBarType.fixed,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.accentColor,
      filled: true,
      prefixIconColor: AppColors.primaryColor,
      suffixIconColor: AppColors.primaryColor,
      hintStyle: TextStyles.body.copyWith(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
