import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Toolbox/design/dark_theme.dart';
import 'package:Toolbox/firebase_options.dart';
import 'package:Toolbox/design/theme.dart';
import 'package:Toolbox/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
