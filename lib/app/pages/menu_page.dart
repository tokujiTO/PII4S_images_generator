import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blue,
      child: SafeArea(
        top: true,
        right: false,
        left: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.rotate(
                angle: 4.7124, // 270 degrees in radians
                child: IconButton(
                  icon: Icon(Icons.menu, color: Colors.white, size: 40),
                  iconSize: 40,
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  splashRadius: 24,
                ),
              ),
              SizedBox(height: 40),
              ListTile(
                leading: Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 40,
                ),
                title: Text(
                  'Gerar nova imagem',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/chat");
                },
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(
                  Icons.article_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                title: Text(
                  'Histórico',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/history");
                },
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white, size: 40),
                title: Text(
                  'Configurações',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/settings");
                },
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.headphones, color: Colors.white, size: 40),
                title: Text(
                  'Entrar em contato',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {},
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.white, size: 40),
                title: Text(
                  'Sair',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
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
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
