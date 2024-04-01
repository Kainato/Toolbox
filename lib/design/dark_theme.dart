import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: false,
  primaryColor: const Color(0xFFF48FB1), // Colors.pink.shade200
  dividerColor: Colors.grey[300],
  fontFamily: GoogleFonts.quicksand().fontFamily,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF1E1E1E),
    elevation: 3,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.quicksand().fontFamily,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    elevation: 0,
    selectedItemColor: Color(0xFFF48FB1), // Colors.pink.shade200
    unselectedItemColor: Colors.grey,
  ),
  cardTheme: const CardTheme(
    color: Color(0xFF1E1E1E),
    shadowColor: Colors.black,
    elevation: 1.0,
  ),
  listTileTheme: const ListTileThemeData(
    visualDensity: VisualDensity.comfortable,
    tileColor: Color(0xFF1E1E1E),
    selectedTileColor: Colors.grey,
    iconColor: Colors.white,
    textColor: Colors.white,
    mouseCursor: MaterialStateMouseCursor.clickable,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFF48FB1), // Colors.pink.shade200
    foregroundColor: Colors.black,
  ),
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    // Primary Colors
    primary: Color(0xFFF48FB1), // Colors.pink.shade200
    onPrimary: Colors.black,
    inversePrimary: Colors.black,
    primaryContainer: Color(0xFFF48FB1), // Colors.pink.shade200
    onPrimaryContainer: Colors.black,
    // Secondary Colors
    secondary: Color(0xFF8ff4d2), // Colors.green.shade200
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFF1ee9a5),
    onSecondaryContainer: Colors.white,
    // Tertiary Colors
    tertiary: Color(0xFF90CAF9), // Colors.blue.shade200
    onTertiary: Colors.black,
    tertiaryContainer: Color(0xFF90CAF9), // Colors.blue.shade200
    onTertiaryContainer: Colors.black,
    // Error Colors
    error: Color(0xFFEF9A9A), // Colors.red.shade200
    onError: Colors.black,
    errorContainer: Color(0xFFEF9A9A), // Colors.red.shade200
    onErrorContainer: Colors.black,
    // Surface Colors
    surfaceTint: Colors.black,
    surface: Color(0xFF121212),
    onSurface: Colors.white,
    inverseSurface: Colors.white,
    onInverseSurface: Colors.black,
    surfaceVariant: Color(0xFF1E1E1E),
    onSurfaceVariant: Colors.white,
    // Background Colors
    background: Color(0xFF121212),
    onBackground: Colors.white,
    // Outline Colors
    outline: Colors.black,
    outlineVariant: Color(0xFFEEEEEE), // Colors.grey[200],
    // Extra Colors
    scrim: Color(0x4D000000),
    shadow: Colors.black,
  ),
);
