import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_dynamic.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';
import 'package:poliedroimagesgenerator/app/controllers/signup_page_controller.dart';
import 'package:provider/provider.dart';

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
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800;

    double fieldWidth = isWeb ? 700 : size.width * 0.8;
    double fieldHeight = isWeb ? 55 : size.height * 0.062;

    // Definição dos campos (Extraído para manter o código limpo)
    Widget fields = Column(
      children: [
        // Nome
        SizedBox(
          width: fieldWidth,
          height: fieldHeight,
          child: CustomTextField(
            focusBorder: AppColors.yellow,
            controller: controller.nameController,
            labelText: 'Nome',
            onChanged: (value) => controller.setName(value),
            suffixIcon: Icon(Icons.person, color: AppColors.white),
          ),
        ),
        SizedBox(height: 16),

        // Email
        SizedBox(
          width: fieldWidth,
          height: fieldHeight,
          child: CustomTextField(
            focusBorder: AppColors.yellow,
            suffixIcon: Icon(Icons.mail, color: AppColors.white),
            labelText: 'E-mail',
            onChanged: (value) => controller.setEmail(value),
            keyboardType: TextInputType.emailAddress,
            controller: controller.emailController,
          ),
        ),
        SizedBox(height: 16),

        // Senha
        SizedBox(
          width: fieldWidth,
          height: fieldHeight,
          child: CustomTextField(
            focusBorder: AppColors.yellow,
            controller: controller.passwordController,
            labelText: 'Senha',
            onChanged: (value) => controller.setPassword(value),
            suffixIcon: controller.isPasswordVisible
                ? Icon(Icons.visibility, color: AppColors.white)
                : Icon(Icons.visibility_off, color: AppColors.white),
            isPassword: !controller.isPasswordVisible,
            onSuffixIconTap: () {
              setState(() {
                controller.togglePasswordVisibility();
              });
            },
          ),
        ),
        SizedBox(height: 16),

        // Confirmar Senha
        SizedBox(
          width: fieldWidth,
          height: fieldHeight,
          child: CustomTextField(
            focusBorder: AppColors.yellow,
            controller: controller.confirmPasswordController,
            labelText: 'Confirmar Senha',
            suffixIcon: controller.isConfirmPasswordVisible
                ? Icon(Icons.visibility, color: AppColors.white)
                : Icon(Icons.visibility_off, color: AppColors.white),
            isPassword: !controller.isConfirmPasswordVisible,
            onSuffixIconTap: () {
              setState(() {
                controller.toggleConfirmPasswordVisibility();
              });
            },
          ),
        ),
        SizedBox(height: 24),
      ],
    );

    return ChangeNotifierProvider(
      create: (_) => controller,
      child: Scaffold(
        body: Consumer<SignupPageController>(
          builder: (context, controller, _) => Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.yellow,
                  AppColors.yellow,
                  AppColors.background,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.1, 0.4],
              ),
            ),
            child: SafeArea(
              // 1. Center: Garante que fique no meio se a tela for grande
              child: Center(
                // 2. SingleChildScrollView: Permite rolar se a tela for pequena (evita erro amarelo)
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/app/assets/PolIG.png',
                        width: isWeb ? 180 : size.width * 0.6,
                      ),
                      const SizedBox(height: 30),
                      fields,
                      Hero(
                        tag: 'signupBtn',
                        child: SizedBox(
                          width: fieldWidth,
                          height: fieldHeight,
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
                            onPressed: () => controller.signup(context),
                            child: controller.isLoading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.yellow,
                                    ),
                                  )
                                : Text(
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
    );
  }
}
