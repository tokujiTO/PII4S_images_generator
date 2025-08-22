import 'package:flutter/material.dart';

class SignupPageController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController codeController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<bool> signup() async {
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
