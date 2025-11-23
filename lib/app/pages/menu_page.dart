import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;
    final menuContent = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 12,
        vertical: isDesktop ? 48 : 24,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isDesktop ? 400 : double.infinity,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
                size: isDesktop ? 48 : 40,
              ),
              iconSize: isDesktop ? 48 : 40,
              onPressed: () => Navigator.of(context).pop(),
              padding: EdgeInsets.zero,
              splashRadius: isDesktop ? 32 : 24,
            ),
            SizedBox(height: isDesktop ? 60 : 40),
            ListTile(
              leading: Icon(
                Icons.auto_awesome,
                color: AppColors.white,
                size: isDesktop ? 48 : 40,
              ),
              title: Text(
                'Gerar nova imagem',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: isDesktop ? 24 : 20,
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/chat");
              },
            ),
            SizedBox(height: isDesktop ? 24 : 16),
            ListTile(
              leading: Icon(
                Icons.article_outlined,
                color: AppColors.white,
                size: isDesktop ? 48 : 40,
              ),
              title: Text(
                'Histórico',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: isDesktop ? 24 : 20,
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/history");
              },
            ),
            SizedBox(height: isDesktop ? 24 : 16),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: AppColors.white,
                size: isDesktop ? 48 : 40,
              ),
              title: Text(
                'Configurações',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: isDesktop ? 24 : 20,
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/settings");
              },
            ),
            SizedBox(height: isDesktop ? 24 : 16),
            ListTile(
              leading: Icon(
                Icons.headphones,
                color: AppColors.white,
                size: isDesktop ? 48 : 40,
              ),
              title: Text(
                'Entrar em contato',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: isDesktop ? 24 : 20,
                ),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/contact");
              },
            ),
            SizedBox(height: isDesktop ? 24 : 16),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: AppColors.white,
                size: isDesktop ? 48 : 40,
              ),
              title: Text(
                'Sair',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: isDesktop ? 24 : 20,
                ),
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/first",
                  (route) => false,
                );
              },
            ),
            Spacer(),
            Hero(
              tag: 'logo',
              child: Image.asset(
                'lib/app/assets/horizontalWhite.png',
                width: isDesktop
                    ? 300
                    : MediaQuery.of(context).size.width * 0.6,
              ),
            ),
          ],
        ),
      ),
    );
    return Material(
      color: AppColors.blue,
      child: SafeArea(
        top: true,
        right: false,
        left: false,
        bottom: true,
        child: isDesktop ? Center(child: menuContent) : menuContent,
      ),
    );
  }
}
