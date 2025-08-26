import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_dynamic.dart';
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
      // appBar: AppBar(backgroundColor: AppColors.background),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
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
                          child: CustomTextField(
                            controller: controller.nameController,
                            labelText: 'Nome',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: CustomTextField(
                            prefixIcon: Icon(Icons.mail),
                            labelText: 'E-mail',
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.emailController,
                          ),
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: CustomTextField(
                            controller: controller.passwordController,
                            labelText: 'Senha',
                            prefixIcon: Icon(Icons.lock),
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
                        SizedBox(height: 24),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: CustomTextField(
                            controller: controller.confirmPasswordController,
                            labelText: 'Confirmar Senha',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: controller.isConfirmPasswordVisible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            isPassword: !controller.isConfirmPasswordVisible,
                            onSuffixIconTap: () {
                              setState(() {
                                controller.toggleConfirmPasswordVisibility();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
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
                SizedBox(height: 24),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CustomTextField(
                    controller: controller.codeController,
                    labelText: 'Código',
                    prefixIcon: Icon(Icons.code),
                  ),
                ),
                SizedBox(height: 24),
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
      ),
    );
  }
}
