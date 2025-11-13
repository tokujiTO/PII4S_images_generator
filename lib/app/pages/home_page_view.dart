import 'dart:ui';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/filter_button.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_ai.dart';
import 'package:poliedroimagesgenerator/app/pages/chat_page_view.dart';
import 'package:poliedroimagesgenerator/app/pages/menu_page.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:poliedroimagesgenerator/app/controllers/home_page_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _fetched = false;

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;
    final TextEditingController controller = TextEditingController();
    return ChangeNotifierProvider(
      create: (_) => HomePageController(),
      child: Consumer<HomePageController>(
        builder: (context, homeController, _) {
          if (!_fetched) {
            _fetched = true;
            homeController.fetchResearches();
          }
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Stack(
              children: [
                // 1. Efeito de brilho verde/ciano no topo
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
                  bottom: false,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.menu,
                                size: 40,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showGeneralDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierLabel: MaterialLocalizations.of(
                                    context,
                                  ).modalBarrierDismissLabel,
                                  barrierColor: Colors.black54,
                                  transitionDuration: const Duration(
                                    milliseconds: 300,
                                  ),
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                        return const _SideSheetMenu();
                                      },
                                  transitionBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        return SlideTransition(
                                          position:
                                              Tween<Offset>(
                                                begin: const Offset(-1.0, 0.0),
                                                end: Offset.zero,
                                              ).animate(
                                                CurvedAnimation(
                                                  parent: animation,
                                                  curve: Curves.easeInOut,
                                                ),
                                              ),
                                          child: child,
                                        );
                                      },
                                );
                              },
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await homeController.fetchResearches();
                          },
                          child: CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 16),
                                      Hero(
                                        tag: 'logo',
                                        child: Image.asset(
                                          'lib/app/assets/horizontalColored.png',
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.9,
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.9,
                                        child: Hero(
                                          tag: 'text_field',
                                          child: Material(
                                            type: MaterialType.transparency,
                                            child: CustomTextAIField(
                                              fillColor: Colors.transparent,
                                              controller: controller,
                                              labelText: "Gerar nova imagem",
                                              suffixIcon: const Icon(
                                                Icons.auto_awesome,
                                                size: 34,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                    ],
                                  ),
                                ),
                              ),
                              isDesktop
                                  ? SliverToBoxAdapter(child: SizedBox(height: 24))
                                  : SliverPersistentHeader(
                                      pinned: true,
                                      delegate: _SliverHeaderDelegate(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: AppColors.blue,
                                              ),
                                              height: 12,
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.9,
                                            ),
                                            const SizedBox(height: 24),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 14,
                                                        horizontal: 16,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          40,
                                                        ),
                                                    color: AppColors.blue,
                                                  ),
                                                  height: 60,
                                                  width:
                                                      MediaQuery.of(
                                                        context,
                                                      ).size.width *
                                                      0.6,
                                                  child: const Text(
                                                    'Últimas Pesquisas',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 23,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                FilterButton(
                                                  onPressed: () {},
                                                  backgroundColor:
                                                      AppColors.blue,
                                                  color: Colors.white,
                                                  iconSize: 40,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        height: 130,
                                      ),
                                    ),
                              // Lista dinâmica de pesquisas
                              isDesktop
                                  ? SliverToBoxAdapter(child: SizedBox(height: 24))
                                  : SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                          if (homeController.isLoading) {
                                            return const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(32.0),
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          }
                                          if (homeController.error != null) {
                                            return Padding(
                                              padding: const EdgeInsets.all(
                                                32.0,
                                              ),
                                              child: Text(
                                                homeController.error!,
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }
                                          if (homeController
                                              .researches
                                              .isEmpty) {
                                            return const Padding(
                                              padding: EdgeInsets.all(32.0),
                                              child: Text(
                                                'Nenhuma pesquisa encontrada.',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }
                                          final item =
                                              homeController.researches[index];
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              24,
                                              0,
                                              24,
                                              16,
                                            ),
                                            child: _buildHistoryCard(
                                              title: item.subject.isNotEmpty
                                                  ? item.subject
                                                  : 'Pesquisa',
                                              description: item.prompt,
                                              imageBytes: item.imageBytes,
                                              chatId: item.id,
                                            ),
                                          );
                                        },
                                        childCount:
                                            homeController.isLoading ||
                                                homeController.error != null ||
                                                homeController
                                                    .researches
                                                    .isEmpty
                                            ? 1
                                            : homeController.researches.length,
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
        },
      ),
    );
  }
}

// O restante do código (_SliverHeaderDelegate, _SideSheetMenu)
// permanece exatamente o mesmo.

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _SliverHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final backgroundColor = overlapsContent
        ? AppColors.gray.withAlpha((0.3 * 255).toInt())
        : Colors.transparent;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: child,
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return height != oldDelegate.height || child != oldDelegate.child;
  }
}

class _SideSheetMenu extends StatelessWidget {
  const _SideSheetMenu();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: isDesktop ? screenWidth / 2 : width,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(2, 0),
            ),
          ],
        ),
        child: const MenuPage(),
      ),
    );
  }
}
