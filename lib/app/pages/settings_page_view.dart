import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget _buildSettingTile(String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 16.0,
            ),
          ),
          dense: true, 
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          onTap: onTap,
        ),
        const Divider(
          color: Colors.white,
          height: 1, // Line thickness
          thickness: 0.5,
          indent: 0,
          endIndent: 0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), 
        child: AppBar(
          backgroundColor: const Color(0xFF00A3A3), 
          elevation: 0, 

          
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios, 
              color: Colors.white, 
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const SizedBox.shrink(),
          centerTitle: false,
        ),
      ),
      
      // --- Body with the menu options ---
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Redefinir nome
            _buildSettingTile('Redefinir nome', () {
              debugPrint('Redefinir nome tapped');
            }),

            // Redefinir senha
            _buildSettingTile('Redefinir senha', () {
              debugPrint('Redefinir senha tapped');
            }),

            // Redefinir email
            _buildSettingTile('Redefinir email', () {
              debugPrint('Redefinir email tapped');
            }),
            
            // Excluir conta - The last item
            _buildSettingTile('Excluir conta', () {
              debugPrint('Excluir conta tapped');
            }),
            
            
          ],
        ),
      ),
    );
  }
}
