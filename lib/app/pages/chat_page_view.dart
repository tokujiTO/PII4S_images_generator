import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_dynamic.dart';

import 'package:provider/provider.dart';
import 'package:poliedroimagesgenerator/app/controllers/chat_controller.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.image,
    this.subject,
    this.description,
    this.chatId,
  });
  final Uint8List? image;
  final String? subject;
  final String? description;
  final String? chatId;

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
    subjectController.text = widget.subject ?? '';
    descriptionController.text = widget.description ?? '';
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
    return ChangeNotifierProvider(
      create: (_) => ChatController(),
      child: Consumer<ChatController>(
        builder: (context, chatController, _) {
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
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
                        const Text(
                          'Chat Page',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

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
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'export_pdf',
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.picture_as_pdf_outlined,
                                        color: AppColors.white,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Exportar para PDF',
                                        style: TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'settings',
                                  onTap: () {
                                    chatController.deleteChat(
                                      widget.chatId,
                                      context,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: AppColors.white,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Deletar conversa',
                                        style: TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 28,
                          ),
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
                      children: [
                        const SizedBox(height: 60),
                        // Exibe imagem e mensagem de resposta, se houver
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (chatController.isLoading)
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  )
                                else ...[
                                  if ((chatController.responseImage == null &&
                                          chatController.responseMessage ==
                                              null) &&
                                      widget.image == null)
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.image_not_supported,
                                            color: Colors.grey,
                                            size: 80,
                                          ),
                                          Text(
                                            'Nenhuma imagem gerada',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (widget.image != null ||
                                      chatController.responseImage != null)
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.memory(
                                          widget.image ??
                                              chatController.responseImage!,
                                          width: 400,
                                          height: 400,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (
                                                context,
                                                error,
                                                stackTrace,
                                              ) => Column(
                                                children: [
                                                  Icon(
                                                    Icons.broken_image,
                                                    color: Colors.red,
                                                    size: 80,
                                                  ),
                                                  Text(
                                                    'Erro ao carregar imagem',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        ),
                                      ),
                                    ),
                                ],
                              ],
                            ),
                          ),
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
                            widget.image != null ||
                                    chatController.isLoading ||
                                    chatController.responseImage != null
                                ? SizedBox.fromSize(size: Size.zero)
                                : FloatingActionButton(
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();
                                      await chatController.sendChat(
                                        subject: subjectController.text,
                                        prompt: descriptionController.text,
                                      );
                                    },
                                    backgroundColor: AppColors.blue,
                                    elevation: 0,
                                    child: const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
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
        },
      ),
    );
  }
}
