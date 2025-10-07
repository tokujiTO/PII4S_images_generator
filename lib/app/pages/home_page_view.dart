import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/components/filter_button.dart';
import 'package:poliedroimagesgenerator/app/components/text_field_ai.dart';
import 'package:poliedroimagesgenerator/app/pages/menu_page.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.background,
      // O AppBar principal permanece o mesmo
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blue,
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 40, color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: MaterialLocalizations.of(
                context,
              ).modalBarrierDismissLabel,
              barrierColor: Colors.black54,
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation, secondaryAnimation) {
                return const _SideSheetMenu();
              },
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
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
      ),
      // Substituímos o Center/Column por uma CustomScrollView
      body: CustomScrollView(
        slivers: [
          // Sliver 1: A parte que vai encolher (logo e campo de texto)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ), // Ajuste o espaçamento conforme necessário
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'lib/app/assets/horizontalColored.png',
                      width: MediaQuery.of(context).size.width * 0.9,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Hero(
                      tag: 'text_field',
                      child: Material(
                        type: MaterialType.transparency,
                        child: CustomTextAIField(
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

          // Sliver 2: O cabeçalho da lista que ficará fixo no topo ao rolar
          SliverPersistentHeader(
            pinned: true, // Isso faz com que ele "grude" no topo
            delegate: _SliverHeaderDelegate(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.white.withAlpha(
                      (0.4 * 255).toInt(),
                    ), // Cor de fundo para não ficar transparente
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.red,
                          ),
                          height: 12,
                          width: MediaQuery.of(context).size.width * 0.9,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.red,
                              ),
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: const Text(
                                'Últimas Pesquisas',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            FilterButton(
                              onPressed: () {},
                              backgroundColor: AppColors.red,
                              color: Colors.white,
                              iconSize: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              height:
                  130, // Altura total do conteúdo (barra + row + espaçamentos)
            ),
          ),

          // Sliver 3: A lista de histórico rolável
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.gray.withAlpha((0.2 * 255).toInt()),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Pesquisa ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: 10, // Número de itens na sua lista
            ),
          ),
        ],
      ),
    );
  }
}

// Classe auxiliar para o SliverPersistentHeader
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
    return child;
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: width,
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
