import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_dynamic.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class RenamePage extends StatelessWidget {
  const RenamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //Web/Desktop
        if (constraints.maxWidth > 800) {
          return _buildWebLayout(context);
        }
        // Mobile
        return _buildMobileLayout(context);
      },
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    const Color highlightColor = AppColors.yellow;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
         //Menu esquerdo
          Container(
            width: 300,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Voltar
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 20),

                Material(
                  color: highlightColor, 
                  child: InkWell(
                    onTap: () {
                      // "Redefinir nome"
                      print("Clicou em Redefinir nome");
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                      child: const Text(
                        'Redefinir nome',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                // Redefinir senha
                _buildWebMenuItem(
                  text: 'Redefinir senha',
                  onTap: () {
                    print("Clicou em Redefinir senha");
                  },
                ),

                //Redefinir e-mail
                _buildWebMenuItem(
                  text: 'Redefinir e-mail',
                  onTap: () {
                    print("Clicou em Redefinir e-mail");
                  },
                ),

                //Excluir conta
                _buildWebMenuItem(
                  text: 'Excluir conta',
                  onTap: () {
                    // COLOQUE AQUI SUA NAVEGAÇÃO
                    print("Clicou em Excluir conta");
                  },
                ),
              ],
            ),
          ),

          //Conteudo lado direito
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.yellow.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                //Formulário
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Digite seu novo nome:',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        CustomTextField(
                          labelText: 'Nome',
                          focusBorder: AppColors.yellow,
                        ),
                        const SizedBox(height: 50),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: highlightColor, width: 2),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Redefinir',
                              style: TextStyle(
                                color: highlightColor,
                                fontSize: 22,
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

  Widget _buildWebMenuItem({required String text, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent, 
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: 2),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  //mobile layout
  Widget _buildMobileLayout(BuildContext context) {
    const Color highlightColor = AppColors.yellow;

    return Scaffold(
      backgroundColor: AppColors.background, 
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 240, // Altura do brilho
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.yellow.withOpacity(1.0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Conteúdo da página
          SafeArea(
            child: Column(
              children: [
                // AppBar - botão de voltar
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

                // Conteúdo original da página
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Digite seu novo nome:',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          labelText: 'Nome',
                          focusBorder: AppColors.yellow,
                        ),
                        const SizedBox(height: 40),
                        // Botão "Redefinir"
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: highlightColor, width: 2),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Redefinir',
                              style: TextStyle(
                                color: highlightColor,
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