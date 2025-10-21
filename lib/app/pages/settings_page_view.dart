import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';
import 'rename_page.dart'; 
import 'reset_passaword_page.dart'; 
import 'change_email_page.dart'; 
import 'delete_account_page.dart'; 

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background , // Fundo preto
      body: Stack( // Usar Stack para sobrepor o brilho
        children: [
          // 1. Efeito de brilho verde/ciano no topo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 240, // Altura da área do brilho
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // Cor ciano com opacidade para criar o efeito de "glow"
                    const Color(0xFF21BFBF).withOpacity(1.0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 2. Conteúdo da página (AppBar + Opções)
          Column(
            children: <Widget>[
              // AppBar original, transparente para mostrar o brilho
              AppBar(
                backgroundColor: Colors.transparent, // Fundo transparente
                elevation: 0,
                leading: IconButton(
                  // Ícone branco para visibilidade
                  icon: const Icon(Icons.arrow_back, color: Colors.white), 
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              // Opções de configuração (do body original)
              _buildOption(
                context,
                'Redefinir nome',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RenamePage()),
                ),
              ),
              _buildOption(
                context,
                'Redefinir senha',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
                ),
              ),
              _buildOption(
                context,
                'Redefinir email',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangeEmailPage()),
                ),
              ),
              _buildOption(
                context,
                'Excluir conta',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeleteAccountPage()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  // ignore: unused_element_parameter
  Widget _buildOption(BuildContext context, String title, VoidCallback onTap, {bool isDelete = false}) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white, width: 0.5), 
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 23,), 
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.transparent, size: 0), // Ícone invisível (para alinhamento)
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
    );
  }
}