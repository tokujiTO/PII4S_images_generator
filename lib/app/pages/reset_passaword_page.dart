import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  int _step = 1; 

  @override
  Widget build(BuildContext context) {
    const Color highlightColor = Color(0xFFFFA500); 

    Widget currentStepWidget;
    switch (_step) {
      case 1:
        currentStepWidget = _buildStep1(highlightColor);
        break;
      case 2:
        currentStepWidget = _buildStep2(highlightColor);
        break;
      case 3:
        currentStepWidget = _buildStep3(highlightColor);
        break;
      default:
        currentStepWidget = Container();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: highlightColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: currentStepWidget,
        ),
      ),
    );
  }

  Widget _buildStep1(Color color) {
    return Column(
      key: const ValueKey<int>(1),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Precisa alterar sua senha?',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(height: 15),
        const Text(
          'Digite seu novo e-mail para efetuarmos a redefinição:',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 20),
        // Campo de texto "E-mail"
        const TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'E-mail',
            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            border: InputBorder.none, 
          ),
          style: TextStyle(color: Colors.black),
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
              // envio do e-mail e avança
              setState(() => _step = 2);
            },
            child: Text(
              'Redefinir',
              style: TextStyle(color: color, fontSize: 18),
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
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Text(
          'exemplo@gmail.com', 
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        
        const Text(
          '_ _ _ _ _ _', // Simulação das linhas
          style: TextStyle(color: Colors.white, fontSize: 30, letterSpacing: 10),
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
              //validação do código e avança
              setState(() => _step = 3);
            },
            child: Text(
              'Enviar',
              style: TextStyle(color: color, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3(Color color) {
    return Column(
      key: const ValueKey<int>(3),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Digite sua nova senha:',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(height: 30),
        _buildPasswordField('Senha'),
        const SizedBox(height: 20),
        _buildPasswordField('Confirme sua senha'),
        const SizedBox(height: 40),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextButton(
            onPressed: () {
            },
            child: Text(
              'Redefinir',
              style: TextStyle(color: color, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String hint) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: InputBorder.none,
        suffixIcon: const Icon(Icons.remove_red_eye_outlined, color: Colors.grey),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}