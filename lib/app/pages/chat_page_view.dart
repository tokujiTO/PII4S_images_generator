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
      appBar: AppBar(
        title: const Text('Chat Page', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Esta função é chamada quando um item do menu é selecionado
              if (value == 'export_pdf') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Funcionalidade "Exportar para PDF" a ser implementada!',
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
                    Icon(Icons.picture_as_pdf_outlined, color: Colors.black54),
                    SizedBox(width: 12),
                    Text('Exportar para PDF'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.black54),
                    SizedBox(width: 12),
                    Text('Deletar conversa'),
                  ],
                ),
              ),
            ],
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 40),
            tooltip: 'Mais opções',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                      // exemplo: enviar ou focar
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
    );
  }
}
