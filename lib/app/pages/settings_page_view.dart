import 'package:flutter/material.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';
import 'rename_page.dart';
import 'reset_password_page.dart';
import 'change_email_page.dart';
import 'delete_account_page.dart';

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //se for web a aba vai sumir
        if (constraints.maxWidth > 800) {
          return const RenamePage();
        }

        //mobile mostra
        return _buildMobileLayout(context);
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Fundo preto
      body: Stack(
        children: [
          //Conteúdo da página 
          SafeArea(
            child: Column(
              children: <Widget>[
                // AppBar original
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                
                // Opções de configuração (agora usando _OptionTile)
                _buildOption(
                  context,
                  'Redefinir nome',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RenamePage()),
                  ),
                  AppColors.yellow,
                ),
                _buildOption(
                  context,
                  'Redefinir senha',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordPage(),
                    ),
                  ),
                  AppColors.yellow,
                ),
                _buildOption(
                  context,
                  'Redefinir email',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangeEmailPage(),
                    ),
                  ),
                  AppColors.yellow,
                ),
                _buildOption(
                  context,
                  'Excluir conta',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeleteAccountPage(),
                    ),
                  ),
                  AppColors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    String title,
    VoidCallback onTap,
    Color pressedColor,
  ) {
    return _OptionTile(
      title: title,
      onTap: onTap,
      pressedColor: pressedColor,
    );
  }
}

class _OptionTile extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final Color pressedColor;

  const _OptionTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.pressedColor,
  }) : super(key: key);

  @override
  State<_OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<_OptionTile> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails _) {
    setState(() => _isPressed = true);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  void _handleTapUp(TapUpDetails _) async {
    // mantém a cor visível por um instante para feedback, depois executa a navegação
    setState(() => _isPressed = true);
    // pequeno delay para o usuário ver o destaque
    await Future.delayed(const Duration(milliseconds: 120));
    // primeiro remove o destaque e só então chama onTap 
    if (!mounted) return;
    setState(() => _isPressed = false);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Container(
        
        color: _isPressed ? widget.pressedColor : Colors.transparent,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white, width: 0.5)),
          ),
          child: ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.white, fontSize: 23),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.transparent,
              size: 0,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
        ),
      ),
    );
  }
}
