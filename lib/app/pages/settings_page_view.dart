// settings_page_view.dart

import 'package:flutter/material.dart';
import 'rename_page.dart'; // Mantido
import 'reset_passaword_page.dart'; // Mantido
import 'change_email_page.dart'; // ALTERADO: Importa a nova página de alteração de e-mail
import 'delete_account_page.dart'; // Mantido

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color highlightColor = Color(0xFF00BCD4); 

    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        backgroundColor: highlightColor, 
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
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
    );
  }

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
          style: const TextStyle(color: Colors.white, fontSize: 16), 
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.transparent, size: 0), // Ícone invisível (para alinhamento)
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
    );
  }
}