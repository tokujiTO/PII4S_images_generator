import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart'; 

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color deleteColor = Color(0xFFE91E63); 

    return Scaffold(
      backgroundColor: AppColors.background , 
      body: Stack( 
        children: [
          // 1. Efeito de brilho ciano no topo (do snippet)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 240, // Altura da área do brilho
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // Cor ciano (do snippet)
                    const Color(0xFFF2275D).withOpacity(1.0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 2. Conteúdo da página (Botão Voltar + Conteúdo Original)
          SafeArea(
            child: Column(
              children: [
                // 2a. Botão de voltar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white), // Ícone branco
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                
                // 2b. Conteúdo original da página
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Excluir conta',
                          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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
                            onPressed: () {
                            },
                            child: const Text(
                              'Excluir',
                              style: TextStyle(color: deleteColor, fontSize: 20),
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
                              Navigator.of(context).pop(); // Volta para a tela anterior
                            },
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.white, fontSize: 20),
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