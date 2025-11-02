import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF3D5242);
  static const Color onPrimary = Color(0xFFEAE0D5);

  static const Color secondary = Color(0xFFBAB0A5);
  static const Color onSecondary = Color(0xFF0A0908);

  static const Color error = Color(0xFF93032E);
  static const Color onError = Color(0xFFEAE0D5);

  static const Color surface = Color(0xFFEAE0D5);
  static const Color onSurface = Color(0xFF0A0908);

  static const Color textPrimary = Color(0xFF0A0908);
  static const Color textSecondary = Color(0xCC0A0908);

  static const Color accent = Color(0xFF5E503F);
  static const Color onAccent = Color(0xFFEAE0D5);

  static ThemeData themeData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        error: error,
        onError: onError,
        surface: surface,
        onSurface: onSurface,
      ),
      scaffoldBackgroundColor: surface,
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: onPrimary,
        displayColor: onPrimary,
      ),
    );
  }
}
