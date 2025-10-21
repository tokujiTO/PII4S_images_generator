import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<bool> signup(context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      errorMessage = 'Preencha todos os campos.';
      notifyListeners();
      return false;
    }

    if (password != confirmPassword) {
      errorMessage = 'As senhas não coincidem.';
      notifyListeners();
      return false;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      print('Enviando requisição de cadastro para o servidor...');
      print('Nome: $name');
      print('Email: $email');
      print('Password: $password');
      http
          .post(
            Uri.parse('http://127.0.0.1:5000/signup'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'nome': name, 'email': email, 'senha': password}),
          )
          .then((response) {
            if (response.statusCode == 201 || response.statusCode == 200) {
              print('Cadastro realizado com sucesso.');
              Navigator.pushNamedAndRemoveUntil(
                context,
                "/home",
                (route) => false,
              );
            } else {
              print('Falha no cadastro: ${response.body}');
            }
          });
      await Future.delayed(const Duration(seconds: 2));
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = 'Erro ao cadastrar. Tente novamente.';
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
