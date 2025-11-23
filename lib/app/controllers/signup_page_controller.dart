import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poliedroimagesgenerator/app/env.dart';

class SignupPageController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController codeController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  String email = '';
  String password = '';
  String name = '';

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  bool _isValidName(String name) {
    return name.trim().length >= 2;
  }

  Future<bool> signup(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty || !_isValidName(name)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Digite um nome válido.')));
      return false;
    }
    if (email.isEmpty || !_isValidEmail(email)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Digite um e-mail válido.')));
      return false;
    }
    if (password.isEmpty || !_isValidPassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A senha deve ter pelo menos 6 caracteres.'),
        ),
      );
      return false;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('As senhas não coincidem.')));
      return false;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Env.loader.makeHttpUri('API_URL', path: '/usuarios')!,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Env.loader.get('API_SECRET_KEY')}',
        },
        body: jsonEncode({'nome': name, 'email': email, 'senha': password}),
      );
      isLoading = false;
      notifyListeners();
      if (response.statusCode == 201 || response.statusCode == 200) {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        return true;
      } else {
        String message = 'Falha no cadastro. Tente novamente.';
        try {
          final body = jsonDecode(response.body);
          if (body is Map && body['error'] != null) {
            message = body['error'].toString();
          }
        } catch (_) {}
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar. Tente novamente.')),
      );
      return false;
    }
  }
}
