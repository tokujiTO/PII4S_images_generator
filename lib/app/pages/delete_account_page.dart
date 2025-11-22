// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //Web
        if (constraints.maxWidth > 800) {
          return _buildWebLayout(context);
        }
        // Mobile
        return _buildMobileLayout(context);
      },
    );
  }

  //web
  Widget _buildWebLayout(BuildContext context) {
    const Color highLightColor = AppColors.red;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
        //menu esquerdo
          Container(
            width: 300,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Botão Voltar
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 20),

                // Itens com linha divisória
                _buildWebMenuItem(text: 'Redefinir nome', onTap: () {}),
                _buildWebMenuItem(text: 'Redefinir senha', onTap: () {}),
                _buildWebMenuItem(text: 'Redefinir e-mail', onTap: () {}),

                Container(
                  width: double.infinity,
                  color: AppColors.red,
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 24,
                  ),
                  child: const Text(
                    'Excluir conta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //conteudo principal
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 350, // Altura do brilho
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.red.withOpacity(0.6), 
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment:
                      Alignment.topCenter, 
                  child: Container(
                    margin: const EdgeInsets.only(top: 120),
                    constraints: const BoxConstraints(maxWidth: 600),
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Título
                        const Text(
                          'Excluir conta',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 60),

                        const Text(
                          'Tem certeza que deseja excluir sua conta?\nIsso apagará permanentemente todas as\nsuas informações.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 100),

                        // Botão Excluir
                        Container(
                          height: 55,
                          width: 700,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.red, width: 2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Ação de excluir
                            },
                            child: const Text(
                              'Excluir',
                              style: TextStyle(
                                color: AppColors.red,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebMenuItem({
    required String text,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 1.5,
              ), 
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  //mobile
  Widget _buildMobileLayout(BuildContext context) {
    const Color deleteColor = Color(0xFFE91E63);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFF2275D).withOpacity(1.0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          //Conteúdo
          SafeArea(
            child: Column(
              children: [
                // Botão de voltar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Excluir conta',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        const Text(
                          'Tem certeza que deseja excluir sua conta?',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Isso apagará permanentemente todas as suas informações.',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 80),
                        // Botão "Excluir"
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: deleteColor, width: 2),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Excluir',
                              style: TextStyle(
                                color: deleteColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
