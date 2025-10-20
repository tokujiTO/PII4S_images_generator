import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class RenamePage extends StatelessWidget {
  const RenamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color highlightColor = AppColors.yellow; 

    return Scaffold(
      backgroundColor: AppColors.background , // Fundo preto
      body: Stack( // Usar Stack para sobrepor o brilho
        children: [
          // 1. Efeito de brilho amarelo no topo
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
                    // Cor amarela com opacidade para criar o efeito de "glow"
                    AppColors.yellow.withOpacity(1.0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 2. Conteúdo da página (AppBar customizado + Conteúdo)
          SafeArea(
            child: Column(
              children: [
                // 2a. AppBar customizado (apenas o botão de voltar)
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
                
                // 2b. Conteúdo original da página
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Digite seu novo nome:',
                          style: TextStyle(color: AppColors.white, fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            hintText: 'Nome',
                            hintStyle: const TextStyle(color: AppColors.gray, fontSize: 15),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.person, color: AppColors.gray),
                            ),
                          ),
                          style: const TextStyle(color: AppColors.background),
                        ),
                        const SizedBox(height: 40),
                        // Botão "Redefinir"
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            // A cor da borda usa a mesma highlightColor (amarela)
                            border: Border.all(color: highlightColor, width: 2),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                            },
                            child: const Text(
                              'Redefinir',
                              style: TextStyle(color: highlightColor, fontSize: 20),
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