import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toolbox/design/dark_theme.dart';
import 'package:toolbox/firebase_options.dart';
import 'package:toolbox/design/theme.dart';
import 'package:toolbox/services/auth_service.dart';
import 'package:toolbox/widgets/functions/auth_check.dart';

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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthService()),
        ],
        child: const AuthCheck(),
      ),
    );
  }
}
