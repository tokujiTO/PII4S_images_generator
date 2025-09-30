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
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 64),
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
            const SizedBox(height: 32),
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
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors.red,
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: const Text(
                    'Últimas Pesquisas',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  for (var i = 0; i < 10; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.gray.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Pesquisa ${i + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
