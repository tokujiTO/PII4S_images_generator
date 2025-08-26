import 'package:flutter/material.dart';

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

  void signIn() {
    // Implement sign-in logic here
  }
}
