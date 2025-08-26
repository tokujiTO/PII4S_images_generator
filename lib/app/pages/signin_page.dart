import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_dynamic.dart';
import 'package:poliedroimagesgenerator/app/controllers/signin_page_controller.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final SignInPageController controller;

  @override
  void initState() {
    super.initState();
    controller = SignInPageController();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'lib/app/assets/verticalColored.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CustomTextField(
                  controller: controller.emailController,
                  labelText: 'E-mail',
                  suffixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CustomTextField(
                  controller: controller.passwordController,
                  labelText: 'Senha',
                  suffixIcon: controller.isPasswordVisible
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  isPassword: !controller.isPasswordVisible,
                  onSuffixIconTap: () {
                    setState(() {
                      controller.togglePasswordVisibility();
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
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
                  'Esqueci minha senha',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.gray,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Hero(
                tag: 'signinBtn',
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.062,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(2),
                      backgroundColor: WidgetStateProperty.all(AppColors.blue),
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
                      'Entrar',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ),
              ),
              // SOH USAR ISSO SE O APPBAR N EXISTIR
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Não tem uma conta?',
              //       style: TextStyle(fontSize: 16, color: AppColors.gray),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         Navigator.pushNamed(context, '/signup');
              //       },
              //       style: ButtonStyle(
              //         elevation: WidgetStateProperty.all(0),
              //         backgroundColor: WidgetStateProperty.all(
              //           AppColors.background,
              //         ),
              //         foregroundColor: WidgetStateProperty.all(
              //           AppColors.background,
              //         ),
              //       ),
              //       child: Text(
              //         'Criar conta',
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: AppColors.gray,
              //           decoration: TextDecoration.underline,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
