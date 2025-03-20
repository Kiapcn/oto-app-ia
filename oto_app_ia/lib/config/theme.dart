import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Couleurs principales avec des nuances de gris sophistiquées
  static const primaryColor = Color(0xFF2B2D42);
  static const secondaryColor = Color(0xFF8D99AE);
  static const backgroundColor = Color(0xFFF8F9FA);
  static const cardColor = Colors.white;
  
  // Nuances de gris pour la hiérarchie visuelle
  static const surfaceLightColor = Color(0xFFF8F9FA);
  static const surfaceMediumColor = Color(0xFFE9ECEF);
  static const surfaceDarkColor = Color(0xFFDEE2E6);
  static const dividerColor = Color(0xFFDEE2E6);
  
  // Couleurs de texte
  static const textPrimaryColor = Color(0xFF2B2D42);
  static const textSecondaryColor = Color(0xFF6C757D);
  static const textTertiaryColor = Color(0xFF8E959E);
  static const textOnPrimaryColor = Colors.white;
  
  // Couleurs d'accentuation
  static const accentColor = Color(0xFF4A90E2);
  static const errorColor = Color(0xFFDC3545);
  static const successColor = Color(0xFF28A745);
  static const warningColor = Color(0xFFFFC107);
  
  // Ombres et élévation
  static const shadowColor = Color(0x1A000000);
  static const elevation1 = 2.0;
  static const elevation2 = 4.0;
  static const elevation3 = 8.0;
  
  // Rayons de bordure
  static const borderRadiusSmall = 8.0;
  static const borderRadiusMedium = 12.0;
  static const borderRadiusLarge = 16.0;

  // Espacement
  static const spacingUnit = 8.0;
  
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundColor,
      surface: cardColor,
      error: errorColor,
      onPrimary: textOnPrimaryColor,
      onSecondary: textPrimaryColor,
      onBackground: textPrimaryColor,
      onSurface: textPrimaryColor,
      onError: textOnPrimaryColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    cardTheme: CardTheme(
      color: cardColor,
      elevation: elevation1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
      ),
      margin: const EdgeInsets.all(spacingUnit),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: cardColor,
      foregroundColor: textPrimaryColor,
      elevation: 0,
      centerTitle: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(borderRadiusSmall),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceLightColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: BorderSide(color: surfaceDarkColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: BorderSide(color: primaryColor),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingUnit * 2,
        vertical: spacingUnit * 1.5,
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
        letterSpacing: -0.3,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textPrimaryColor,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondaryColor,
        height: 1.4,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: textOnPrimaryColor,
        elevation: elevation1,
        padding: EdgeInsets.symmetric(
          horizontal: spacingUnit * 3,
          vertical: spacingUnit * 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: textSecondaryColor,
      size: 24,
    ),
  );
} 