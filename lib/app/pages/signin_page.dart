import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_dynamic.dart';
import 'package:poliedroimagesgenerator/app/controllers/signin_page_controller.dart';
import 'package:poliedroimagesgenerator/app/pages/reset_password_page.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';
import 'package:provider/provider.dart';

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
    // 1. Pega o tamanho real da tela/janela
    final size = MediaQuery.of(context).size;

    // 2. Define se é "Web" baseando-se na LARGURA (> 800px),
    // e não apenas se está rodando no navegador. Isso permite redimensionar.
    final isWeb = size.width > 800;

    // 3. Define as medidas dinâmicas baseadas na regra acima
    final double fieldWidth = isWeb ? 700 : size.width * 0.8;
    final double fieldHeight = isWeb ? 55 : size.height * 0.062;

    return ChangeNotifierProvider(
      create: (_) => controller,
      child: Scaffold(
        body: Consumer<SignInPageController>(
          builder: (context, controller, _) => Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.white,
                  AppColors.white,
                  AppColors.background,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.1, 0.4],
              ),
            ),
            child: SafeArea(
              // 4. Center + SingleChildScrollView: O segredo para não estourar a tela
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Importante para o scroll funcionar bem
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
                        width: fieldWidth,
                        child: CustomTextField(
                          controller: controller.emailController,
                          onChanged: controller.updateEmail,
                          fillColor: Colors.transparent,
                          labelText: 'E-mail',
                          suffixIcon: Icon(
                            Icons.person,
                            color: AppColors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // CAMPO SENHA
                      SizedBox(
                        width: fieldWidth,
                        child: CustomTextField(
                          controller: controller.passwordController,
                          fillColor: Colors.transparent,
                          onChanged: controller.updatePassword,
                          labelText: 'Senha',
                          suffixIcon: controller.isPasswordVisible
                              ? Icon(Icons.visibility, color: AppColors.white)
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

                      const SizedBox(height: 30),

                      // ESQUECI SENHA
                      SizedBox(
                        width: fieldWidth,
                        child: Align(
                          alignment: Alignment
                              .center, // Centraliza o botão ou ajusta conforme design
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ResetPasswordPage(loginFlow: true,),
                              ),
                            ),
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all(0),
                              backgroundColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                              overlayColor: WidgetStateProperty.all(
                                AppColors.white.withOpacity(0.1),
                              ),
                              shadowColor: WidgetStateProperty.all(
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
                        ),
                      ),

                      const SizedBox(height: 30),

                      // BOTÃO ENTRAR
                      Hero(
                        tag: 'signinBtn',
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
                                    color: AppColors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () => controller.signIn(context),
                            child: controller.isLoading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.white,
                                    ),
                                  )
                                : Text(
                                    'Entrar',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: AppColors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
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
