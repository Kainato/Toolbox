import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toolbox/pages/login_page.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

/// AuthService extende ChangeNotifier para que possamos notificar em todas
/// as telas que estão com a instância de AuthService (por meio de Provider)
/// quando o estado de autenticação mudar.
class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    // Verifica se o usuário está logado
    _auth.authStateChanges().listen((User? newUser) {
      // Se o usuário estiver logado, newUser será diferente de null
      usuario = (newUser == null) ? null : newUser;
      isLoading = false;
    });
    // Notifica os listeners que o estado de autenticação mudou
    notifyListeners();
  }

  register({required String email, required String senha}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao registrar: $e', error: e, stackTrace: s);
      if (e.code == 'weak-password') {
        throw AuthException('A senha inserida é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('O email já está em uso.');
      } else {
        throw AuthException('Erro desconhecido: $e');
      }
    }
  }

  login({required String email, required String senha}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao registrar: $e',
          error: e, stackTrace: s, name: 'AuthService');
      if (e.code == 'user-not-found') {
        throw AuthException('Usuário não encontrado!');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta! Tente novamente.');
      } else {
        throw AuthException('Erro desconhecido: $e');
      }
    }
  }

  logout(BuildContext context) async {
    try {
      await _auth.signOut();
      _getUser();
      context.mounted
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            )
          : null;
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao registrar: $e', error: e, stackTrace: s);
      throw AuthException('Erro ao sair: $e');
    }
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }
}
