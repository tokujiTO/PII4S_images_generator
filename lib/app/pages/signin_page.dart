import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.background),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset(
                'lib/app/assets/verticalColored.png',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
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
                    style: TextStyle(fontSize: 24, color: AppColors.background),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
