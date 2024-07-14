import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toolbox/pages/home_page.dart';
import 'package:toolbox/pages/login_page.dart';
import 'package:toolbox/services/auth_service.dart';

/// AuthCheck é um StatefulWidget que verifica se o usuário está logado.
/// Se o usuário estiver logado, AuthCheck retorna a página inicial.
/// Se o usuário não estiver logado, AuthCheck retorna a página de login.
class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return const LoginPage();
    } else {
      return const HomePage();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
