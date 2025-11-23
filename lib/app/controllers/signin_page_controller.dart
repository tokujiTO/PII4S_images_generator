import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poliedroimagesgenerator/app/env.dart';
import 'package:poliedroimagesgenerator/app/pages/change_email_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPageController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _email = 'tiagomassuda123@gmail.com';
  String _password = 'Teste123@';
  bool isLoading = false;

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
    isLoading = true;
    notifyListeners();

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
          Env.loader.makeHttpUri('API_URL', path: '/login')!,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Env.loader.get('API_SECRET_KEY')}',
          },
          body: jsonEncode({'email': _email, 'senha': _password}),
        )
        .then((response) async {
          if (response.statusCode == 200 || response.statusCode == 201) {
            // guarda o userID e nome do usuário, se necessário
            final body = jsonDecode(response.body);
            if (body is Map) {
              final userID = body["usuario"]['user_id'];
              final userName = body["usuario"]['nome'];
              final email = body["usuario"]['email'];
              print('UserID: $userID, Nome: $userName, Email: $email');
              // Armazena o userID e o nome do usuário no local storage ou estado global, se necessário
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('email', email);
              await prefs.setString('userId', userID);
              await prefs.setString('userName', userName);
            }
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
          isLoading = false;
          notifyListeners();
        })
        .catchError((error) {
          // Impede de mandar novamente se já houver um snackbar visível
          if (ScaffoldMessenger.of(context).mounted) {
            print('Erro de conexão: $error');
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Erro de conexão: $error')));
          }
          isLoading = false;
          notifyListeners();
        });
  }
}
