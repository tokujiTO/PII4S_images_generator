import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_dynamic.dart';
import 'package:poliedroimagesgenerator/app/pages/chat_page_view.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:poliedroimagesgenerator/app/controllers/history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _fetched = false;

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
              size: 28,
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          const SizedBox(width: 10),
          const Text(
            'Histórico',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(child: CustomTextField(labelText: 'Pesquisar no histórico')),
          const SizedBox(width: 10),

          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: AppColors.blue, width: 2),
            ),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'physics') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Física selecionada',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
              color: AppColors.background,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'physics',
                  child: Row(
                    children: [
                      Icon(
                        Icons.picture_as_pdf_outlined,
                        color: AppColors.white,
                      ),
                      SizedBox(width: 12),
                      Text('Física', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'chemistry',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: AppColors.white),
                      SizedBox(width: 12),
                      Text('Química', style: TextStyle(color: AppColors.white)),
                    ],
                  ),
                ),
              ],
              icon: const Icon(Icons.filter_alt, color: Colors.white, size: 28),
              tooltip: 'Mais opções',
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(HistoryController controller) {
    if (controller.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (controller.error != null) {
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          controller.error!,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }
    if (controller.historyItems.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32.0),
        child: Text(
          'Nenhum histórico encontrado.',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: controller.historyItems.length,
      itemBuilder: (context, index) {
        final item = controller.historyItems[index];
        return _buildHistoryCard(
          title: item.subject.isNotEmpty ? item.subject : 'Histórico',
          description: item.prompt,
          imageBytes: item.imageBytes,
          chatId: item.id,
        );
      },
    );
  }

  Widget _buildHistoryCard({
    required String title,
    required String description,
    Uint8List? imageBytes,
    required String chatId,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                description: description,
                image: imageBytes,
                subject: title,
                chatId: chatId,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: AppColors.gray, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(color: AppColors.gray, fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: imageBytes != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            imageBytes,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.image, color: AppColors.gray, size: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HistoryController(),
      child: Consumer<HistoryController>(
        builder: (context, historyController, _) {
          if (!_fetched) {
            _fetched = true;
            historyController.fetchHistory();
          }
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
                SafeArea(
                  top: true,
                  bottom: false,
                  left: true,
                  right: true,
                  child: Column(
                    children: [
                      _buildAppBar(context),
                      _buildSearchBar(),
                      Expanded(child: _buildHistoryList(historyController)),
                    ],
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
