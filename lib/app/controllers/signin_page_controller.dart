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

  void signIn(context) {
    print('Attempting to sign in with email: $_email');
    print('Attempting to sign in with password: $_password');
    http
        .post(
          Uri.parse('http://127.0.0.1:5000/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': _email, 'senha': _password}),
        )
        .then((response) {
          if (response.statusCode == 200 || response.statusCode == 201) {
            print('Sign in successful');
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/home",
              (route) => false,
            );
          } else {
            print('Sign in failed: ${response.body}');
          }
        })
        .catchError((error) {
          print('Error during sign in: $error');
        });
  }
}
