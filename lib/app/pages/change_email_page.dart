import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({Key? key}) : super(key: key);

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  int _step = 1;

  @override
  Widget build(BuildContext context) {
    // cor mesma do brilho
    const Color highlightColor = AppColors.yellow;

    Widget currentStepWidget;
    switch (_step) {
      case 1:
        currentStepWidget = _buildStep1(AppColors.yellow);
        break;
      case 2:
        currentStepWidget = _buildStep2(AppColors.yellow);
        break;
      case 3:
        currentStepWidget = _buildStep3(AppColors.yellow);
        break;
      default:
        currentStepWidget = Container();
    }

    return Scaffold(
      backgroundColor: AppColors.background , 
      body: Stack( // Usar Stack para sobrepor o brilho
        children: [
          // 1. Efeito de brilho verde/ciano no topo
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
                    // Cor ciano com opacidade para criar o efeito de "glow"
                    AppColors.yellow.withOpacity(1.0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 2. Conteúdo da página (AppBar customizado + Steps)
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
                // 2b. O conteúdo dos steps
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: currentStepWidget,
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

  Widget _buildStep1(Color color) {
    return Column(
      key: const ValueKey<int>(1),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Quer alterar seu e-mail?',
          style: TextStyle(color: AppColors.white, fontSize: 25),
        ),
        const SizedBox(height: 15),
        const Text(
          'Digite seu novo e-mail para efetuarmos a redefinição:',
          style: TextStyle(color: AppColors.white, fontSize: 20),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            hintText: 'E-mail',
            contentPadding: EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 20.0,
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(color: AppColors.background),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 40),
        // Botão "Redefinir"
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextButton(
            onPressed: () {
              setState(() => _step = 2);
            },
            child: Text(
              'Redefinir',
              style: TextStyle(color: color , fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2(Color color) {
    return Column(
      key: const ValueKey<int>(2),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Digite o código que enviamos agora para:',
          style: TextStyle(color: AppColors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Text(
          'exemplo@gmail.com',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        const Text(
          '_ _ _ _ _ _',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 30,
            letterSpacing: 10,
          ),
        ),
        const SizedBox(height: 60),
        // Botão "Enviar"
        Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextButton(
            onPressed: () {
              setState(() => _step = 3);
            },
            child: Text('Enviar', style: TextStyle(color: color, fontSize: 20)),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3(Color color) {
    return Column(
      key: const ValueKey<int>(3),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'E-mail redefinido com sucesso!',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 60),
        // Botão "Início"
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Início', style: TextStyle(color: color, fontSize: 20)),
          ),
        ),
      ],
    );
  }
}