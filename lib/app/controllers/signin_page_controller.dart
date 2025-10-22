import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignInPageController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    notifyListeners();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  void signIn(BuildContext context) {
    if (_email.isEmpty || !_isValidEmail(_email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor insira um e-mail válido')),
      );
      return;
    }
    if (_password.isEmpty || !_isValidPassword(_password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A senha deve ter pelo menos 6 caracteres'),
        ),
      );
      return;
    }

    http
        .post(
          Uri.parse('http://127.0.0.1:5000/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': _email, 'senha': _password}),
        )
        .then((response) {
          if (response.statusCode == 200 || response.statusCode == 201) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/home",
              (route) => false,
            );
          } else {
            String message = 'Falha ao entrar. Tente novamente.';
            try {
              final body = jsonDecode(response.body);
              if (body is Map && body['error'] != null) {
                message = body['error'].toString();
              }
            } catch (_) {}
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          }
        })
        .catchError((error) {
          // Impede de mandar novamente se já houver um snackbar visível
          if (ScaffoldMessenger.of(context).mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Erro de conexão: $error')));
          }
        });
  }
}
