import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.1,
          ),
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
                const Expanded(child: SizedBox()),
                Hero(
                  tag: 'signinBtn',
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.062,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(2),
                        backgroundColor: WidgetStateProperty.all(
                          AppColors.blue,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      onPressed: () => {
                        Navigator.pushNamed(context, "/signin"),
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
                const SizedBox(height: 20),
                Text("Ou", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
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
                        Navigator.pushNamed(context, "/signup"),
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
