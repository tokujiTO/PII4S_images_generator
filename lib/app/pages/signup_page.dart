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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.yellow,    
              AppColors.yellow,    
              AppColors.background 
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.0,
              0.1, 
              0.4, 
            ],
        ),
      ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    // Ensure the column takes at least the full available height
                    minHeight: MediaQuery.of(context).size.height - 40,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'lib/app/assets/PolIG.png',
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                        SizedBox(height: 16),
                        Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: CustomTextField(
                                    controller: controller.nameController,
                                    labelText: 'Nome',
                                    suffixIcon: Icon(
                                      Icons.person,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: CustomTextField(
                                    suffixIcon: Icon(
                                      Icons.mail,
                                      color: AppColors.white,
                                    ),
                                    labelText: 'E-mail',
                                    keyboardType: TextInputType.emailAddress,
                                    controller: controller.emailController,
                                  ),
                                ),
                                SizedBox(height: 24),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: CustomTextField(
                                    controller: controller.passwordController,
                                    labelText: 'Senha',
                                    suffixIcon: controller.isPasswordVisible
                                        ? Icon(
                                            Icons.visibility,
                                            color: AppColors.white,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: AppColors.white,
                                          ),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: CustomTextField(
                                    controller:
                                        controller.confirmPasswordController,
                                    labelText: 'Confirmar Senha',
                                    suffixIcon:
                                        controller.isConfirmPasswordVisible
                                        ? Icon(
                                            Icons.visibility,
                                            color: AppColors.white,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: AppColors.white,
                                          ),
                                    isPassword:
                                        !controller.isConfirmPasswordVisible,
                                    onSuffixIconTap: () {
                                      setState(() {
                                        controller
                                            .toggleConfirmPasswordVisibility();
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
                              Colors.transparent,
                            ),
                            foregroundColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                          child: Text(
                            'Enviar código de verificação',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.white,
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
                            keyboardType: TextInputType.number,
                            prefixIcon: Icon(
                              Icons.code,
                              color: AppColors.white,
                            ),
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
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.transparent,
                                ),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: BorderSide(
                                      color: AppColors.yellow,
                                      width: 2,
                                    ),
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
                                  color: AppColors.yellow,
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
            ),
          ),
        ),
      ),
    );
  }
}
