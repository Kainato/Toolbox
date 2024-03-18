import 'package:flutter/material.dart';
import 'package:toolbox/dark_theme.dart';
import 'package:toolbox/theme.dart';
import 'package:toolbox/widgets/BackgroundPage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: const BackgroundPage(
        title: 'Home Page',
        children: [],
      ),
    );
  }
}
