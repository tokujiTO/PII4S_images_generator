import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_dynamic.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode descriptionFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) descriptionFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    subjectController.dispose();
    descriptionController.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, 
      body: Stack( 
        children: [
          // Efeito de brilho no topo
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
          
          // Conteúdo da "AppBar" customizada (seta, título e ações)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Seta de Voltar
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 24,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  
                  // Título
                  const Text('Chat Page', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  
                  // Botão de Mais Opções
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'export_pdf') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Funcionalidade "Exportar para PDF" a ser implementada!',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                    color: AppColors.background,
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'export_pdf',
                        child: Row(
                          children: [
                            Icon(Icons.picture_as_pdf_outlined, color: AppColors.white),
                            SizedBox(width: 12),
                            Text(
                              'Exportar para PDF',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'settings',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: AppColors.white),
                            SizedBox(width: 12),
                            Text(
                              'Deletar conversa',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                    icon: const Icon(Icons.more_vert, color: Colors.white, size: 28),
                    tooltip: 'Mais opções',
                  ),
                ],
              ),
            ),
          ),
          
          // Conteúdo Principal da Tela (Formulário, etc.)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                // O padding no topo precisa ser maior para descer abaixo da AppBar customizada
                children: [
                  const SizedBox(height: 60), // Espaçamento para o conteúdo da "AppBar" customizada
                  // O restante do seu corpo (body) aqui
                  Expanded(
                    child: Container(), // Área de conversa (vazia neste snippet)
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: subjectController,
                          labelText: 'Matéria',
                        ),
                      ),
                      const SizedBox(width: 12),
                      FloatingActionButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                        backgroundColor: AppColors.blue,
                        elevation: 0,
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Hero(
                    tag: 'text_field',
                    child: Material(
                      type: MaterialType.transparency,
                      child: CustomTextField(
                        controller: descriptionController,
                        labelText: 'Descrição',
                        minLines: 1,
                        focusNode: descriptionFocusNode,
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
  }
}