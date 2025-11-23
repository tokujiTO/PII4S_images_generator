import 'package:flutter/foundation.dart'; 
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
    // --- TAMANHOS QUE DEVEM SER USADOS NA WEB ---
    final double webButtonWidth = 700; // igual ao usado na tela de cadastro
    final double webButtonHeight = 55; // igual ao usado na tela de cadastro

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.white, AppColors.white, AppColors.background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.1, 0.4],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'lib/app/assets/horizontalColored.png',
                    width: 350,
                  ),
                ),

                const SizedBox(height: 40),

                // CAMPO EMAIL
                SizedBox(
                  width: kIsWeb
                      ? webButtonWidth
                      : MediaQuery.of(context).size.width * 0.8,
                  child: CustomTextField(
                    controller: controller.emailController,
                    onChanged: controller.updateEmail,
                    fillColor: Colors.transparent,
                    labelText: 'E-mail',
                    suffixIcon: Icon(Icons.person, color: AppColors.white),
                  ),
                ),

                SizedBox(height: 20),

                // CAMPO SENHA
                SizedBox(
                  width: kIsWeb
                      ? webButtonWidth
                      : MediaQuery.of(context).size.width * 0.8,
                  child: CustomTextField(
                    controller: controller.passwordController,
                    fillColor: Colors.transparent,
                    onChanged: controller.updatePassword,
                    labelText: 'Senha',
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

                const SizedBox(height: 30),

                // ESQUECI SENHA
                ElevatedButton(
                  onPressed: () {},
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
                    'Esqueci minha senha',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // BOTÃO ENTRAR
                Hero(
                  tag: 'signinBtn',
                  child: SizedBox(
                    width: kIsWeb
                        ? webButtonWidth
                        : MediaQuery.of(context).size.width * 0.8,
                    height: kIsWeb
                        ? webButtonHeight
                        : MediaQuery.of(context).size.height * 0.062,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(2),
                        backgroundColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(color: AppColors.white, width: 2),
                          ),
                        ),
                      ),
                      onPressed: () => controller.signIn(context),
                      child: Text(
                        'Entrar',
                        style:
                            TextStyle(fontSize: 25, color: AppColors.white),
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
