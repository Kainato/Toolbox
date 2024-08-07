import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  useMaterial3: false,
  primaryColor: Colors.pink,
  dividerColor: Colors.grey[300],
  fontFamily: GoogleFonts.quicksand().fontFamily,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
        TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.quicksand().fontFamily,
        ),
      ),
      backgroundColor: WidgetStateProperty.all(Colors.pink),
      elevation: WidgetStateProperty.all(3.0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.pink,
    elevation: 3,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.quicksand().fontFamily,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.pink),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.grey),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.red),
    ),
    labelStyle: TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    hintStyle: TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    selectedItemColor: Colors.pink,
    unselectedItemColor: Colors.grey,
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
    shadowColor: Colors.black,
    elevation: 1.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    visualDensity: VisualDensity.comfortable,
    tileColor: Colors.white,
    selectedTileColor: Colors.grey,
    iconColor: Colors.black,
    textColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.pink,
    foregroundColor: Colors.white,
  ),
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    // Primary Colors
    primary: Colors.pink,
    onPrimary: Colors.white,
    inversePrimary: Colors.white,
    primaryContainer: Colors.pink,
    onPrimaryContainer: Colors.white,
    // Secondary Colors
    secondary: Color(0xFF1ee9a5),
    onSecondary: Colors.black,
    secondaryContainer: Color(0xFF1ee9a5),
    onSecondaryContainer: Colors.black,
    // Tertiary Colors
    tertiary: Colors.blue,
    onTertiary: Colors.white,
    tertiaryContainer: Colors.blue,
    onTertiaryContainer: Colors.white,
    // Error Colors
    error: Colors.red,
    onError: Colors.white,
    errorContainer: Colors.red,
    onErrorContainer: Colors.white,
    // Surface Colors
    surfaceTint: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    inverseSurface: Colors.black,
    onInverseSurface: Colors.white,
    surfaceContainerHighest: Color(0xFFEEEEEE), // Colors.grey[200],
    onSurfaceVariant: Colors.black,
    // Outline Colors
    outline: Colors.black,
    outlineVariant: Color(0xFFEEEEEE), // Colors.grey[200],
    // Extra Colors
    scrim: Color(0x4D000000),
    shadow: Colors.black,
  ),
);
