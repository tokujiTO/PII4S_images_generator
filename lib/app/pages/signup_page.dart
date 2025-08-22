import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';
import 'package:poliedroimagesgenerator/app/controllers/signup_page_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final SignupPageController controller;

  @override
  void initState() {
    super.initState();
    controller = SignupPageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.background),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'lib/app/assets/verticalColored.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ),
              Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: controller.nameController,
                          decoration: const InputDecoration(labelText: 'Nome'),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: controller.emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: controller.passwordController,
                          decoration: const InputDecoration(labelText: 'Senha'),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: controller.confirmPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Confirmar Senha',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle sign up logic
                },
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(0),
                  backgroundColor: WidgetStateProperty.all(
                    AppColors.background,
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    AppColors.background,
                  ),
                ),
                child: Text(
                  'Enviar código de verificação',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.gray,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: controller.codeController,
                  decoration: const InputDecoration(labelText: 'Código'),
                ),
              ),
              Hero(
                tag: 'signupBtn',
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.062,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(2),
                      backgroundColor: WidgetStateProperty.all(AppColors.red),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    onPressed: () => {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/home",
                        (route) => false,
                      ),
                    },
                    child: Text(
                      'Cadastrar-se',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
