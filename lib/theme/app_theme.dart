import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Glassmorphism Core Palette
  static const Color primaryBlue = Color(0xFF007AFF); // Apple System Blue
  static const Color primaryBlueDark = Color(0xFF005BB5); // Darker Blue
  static const Color primaryGreen = Color(0xFF34C759); // Apple System Green
  static const Color alertRed = Color(0xFFFF3B30); // Apple System Red
  
  static const Color darkBackground = Color(0xFF000000); // Deep Black
  static const Color lightBackground = Color(0xFFF2F2F7); // Apple System Gray 6

  // Glass Container Colors (Context Aware)
  static Color glassBg(BuildContext context) => ThemeController.isDark(context)
      ? Colors.white.withAlpha(20)
      : Colors.white.withAlpha(180);

  static Color glassBorder(BuildContext context) => ThemeController.isDark(context)
      ? Colors.white.withAlpha(30)
      : Colors.white.withAlpha(255);

  static Color glassShadow(BuildContext context) => ThemeController.isDark(context)
      ? Colors.black.withAlpha(100)
      : Colors.black.withAlpha(15);

  // Text Colors
  static Color text(BuildContext context) => ThemeController.isDark(context)
      ? Colors.white
      : Colors.black87;

  static Color textSub(BuildContext context) => ThemeController.isDark(context)
      ? Colors.white60
      : Colors.black54;

  static Color textMuted(BuildContext context) => ThemeController.isDark(context)
      ? Colors.white38
      : Colors.black38;

  // Aliases for compatibility with old views
  static Color bg(BuildContext context) => ThemeController.isDark(context)
      ? darkBackground
      : lightBackground;
      
  static Color cardBg(BuildContext context) => glassBg(context);
  static Color cardElevated(BuildContext context) => glassBg(context);
  static Color border(BuildContext context) => glassBorder(context);
  static Color chipBg(BuildContext context) => ThemeController.isDark(context)
      ? primaryBlue.withAlpha(40)
      : primaryBlue.withAlpha(20);
}

class ThemeController {
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.dark);

  static bool isDark(BuildContext context) {
    if (themeMode.value == ThemeMode.system) {
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    }
    return themeMode.value == ThemeMode.dark;
  }

  static void toggleTheme() {
    themeMode.value =
        themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.transparent,
      primaryColor: AppColors.primaryBlue,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryGreen,
        surface: AppColors.darkBackground,
        error: AppColors.alertRed,
      ),
      // Glassmorphism pairs well with clean sans-serif like Inter or SF Pro. We use Inter here.
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.transparent,
      primaryColor: AppColors.primaryBlue,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryGreen,
        surface: AppColors.lightBackground,
        error: AppColors.alertRed,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
