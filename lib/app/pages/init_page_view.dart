import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // gradient background applied via a Container decoration
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gray, AppColors.background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
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
                      'lib/app/assets/horizontalColored.png',
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
                        onPressed: () => {
                          Navigator.pushNamed(context, "/signin"),
                        },
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Ou",
                    style: TextStyle(fontSize: 16, color: AppColors.white),
                  ),
                  const SizedBox(height: 20),
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
                          Navigator.pushNamed(context, "/signup"),
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
    );
  }
}
