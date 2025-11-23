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
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800; // define web layout

    Widget fields = Column(
      children: [
        // Nome
        SizedBox(
          width: isWeb ? 500 : size.width * 0.8,
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
          width: isWeb ? 500 : size.width * 0.8,
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
          width: isWeb ? 500 : size.width * 0.8,
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

        // Confirmar senha
        SizedBox(
          width: isWeb ? 500 : size.width * 0.8,
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

    Widget signupButton = Hero(
      tag: 'signupBtn',
      child: SizedBox(
        width: isWeb ? 500 : size.width * 0.8,
        height: size.height * 0.062,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(2),
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
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
          child: Text(
            'Cadastrar-se',
            style: TextStyle(
              fontSize: 24,
              color: AppColors.yellow,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.yellow, AppColors.yellow, AppColors.background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.1, 0.4],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: isWeb
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/app/assets/PolIG.png',
                        width: 180,
                      ),
                      SizedBox(height: 30),
                      fields,
                      signupButton,
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'lib/app/assets/PolIG.png',
                          width: size.width * 0.6,
                        ),
                        fields,
                        signupButton,
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
