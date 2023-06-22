import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  final String? message;
  AuthException(this.message);
}

class AuthSevices extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoanding = true;

  AuthSevices() {
    _authcheck();
  }

  _authcheck() async {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoanding = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Usuário não encontrado');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta');
      } else {
        throw AuthException(e.message);
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
