import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_dynamic.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class ContactPageView extends StatefulWidget {
  const ContactPageView({super.key});

  @override
  State<ContactPageView> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPageView> {
  // Controller para gerenciar o texto digitado no campo de mensagem
  final TextEditingController _messageController = TextEditingController();

  // Chave para identificar e validar o formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _sendMessage() {
    if (_formKey.currentState?.validate() ?? false) {
      final message = _messageController.text;
      print('Mensagem enviada: $message');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mensagem enviada com sucesso!')),
      );
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    const Color(0xFF21BFBF).withOpacity(1.0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 2. Conteúdo da tela
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CustomAppBarContent(
                    title: 'Contato',
                    onBack: () => Navigator.of(context).pop(),
                    color: AppColors.white,
                  ),

                  const SizedBox(height: 16),

                  // Instrução de texto
                  const Text(
                    'Envie uma mensagem para a nossa equipe de desenvolvedores:',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 30),

                  // Campo de Texto
                  Form(
                    key: _formKey,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent, // Fundo transparente
                        borderRadius: BorderRadius.circular(10.0),
                        // border: Border.all(color: AppColors.blue, width: 2),
                      ),
                      // child: TextFormField(
                      //   controller: _messageController,
                      //   maxLines: 10,
                      //   minLines: 5,
                      //   keyboardType: TextInputType.multiline,
                      //   decoration: const InputDecoration(
                      //     hintText: 'Mensagem',
                      //     hintStyle: TextStyle(color: AppColors.gray),
                      //     border: InputBorder.none,
                      //     contentPadding: EdgeInsets.all(16.0),
                      //   ),
                      //   style: const TextStyle(color: AppColors.background),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Por favor, digite sua mensagem.';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      child: CustomTextField(
                        labelText: 'Mensagem',
                        controller: _messageController,
                        maxLines: 10,
                        minLines: 5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Botão Enviar (OutlinedButton)
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: _sendMessage,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        // Borda ciano
                        side: const BorderSide(color: AppColors.blue, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
    );
    // END: Estrutura usando Stack
  }
}

// Widget auxiliar para replicar o conteúdo da AppBar (Seta + Título)
class CustomAppBarContent extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final Color color;

  const CustomAppBarContent({
    super.key,
    required this.title,
    required this.onBack,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Título Centralizado
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          // Seta de Voltar no Canto Esquerdo
          Positioned(
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: color),
              onPressed: onBack,
            ),
          ),
        ],
      ),
    );
  }
}
