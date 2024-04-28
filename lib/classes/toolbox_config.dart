import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToolBoxConfig {
  static double getScreenHeightPadding(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    double topPadding = MediaQuery.of(context).padding.top;
    double toolbarHeight = kToolbarHeight;
    double bottomNavigationBarHeight = kBottomNavigationBarHeight;
    return screenHeight -
        bottomPadding -
        topPadding -
        toolbarHeight -
        bottomNavigationBarHeight -
        20;
  }

  // final String? fontFamily = GoogleFonts.quicksand().fontFamily;
  static String? getFontFamily() {
    return GoogleFonts.quicksand().fontFamily;
  }

  static SnackBar getSnackBar({
    required String content,
    required Color backgroundColor,
    int duration = 4,
  }) {
    return SnackBar(
      duration: Duration(seconds: duration),
      content: Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: ToolBoxConfig.getFontFamily(),
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
