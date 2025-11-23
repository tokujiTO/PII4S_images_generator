import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poliedroimagesgenerator/app/components/text_field_dynamic.dart';
import 'package:poliedroimagesgenerator/app/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_email_page.dart';
import 'reset_password_page.dart';
import 'delete_account_page.dart';

class RenamePage extends StatelessWidget {
  const RenamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return _buildWebLayout(context);
        }
        return _buildMobileLayout(context);
      },
    );
  }

  Future<void> _renameUser(BuildContext context, String newName) async {
    final prefs = await SharedPreferences.getInstance();
    final userMail = prefs.getString('email') ?? '';
    final uri = Uri.parse('http://127.0.0.1:5000/usuarios/$userMail');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nome': newName}),
    );
    if (response.statusCode == 200) {
      print('Nome atualizado com sucesso.');
      print(response.body);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      print('Falha ao atualizar o nome. Código: ${response.statusCode}');
    }
  }

  Widget _buildWebLayout(BuildContext context) {
    const Color highlightColor = AppColors.yellow;
    String newName = '';
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Container(
            width: 300,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 20),

                //Botão: Redefinir Nome
                Material(
                  color: highlightColor,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const RenamePage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 24,
                      ),
                      child: const Text(
                        'Redefinir nome',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                // Botão: Redefinir Senha
                _buildWebMenuItem(
                  text: 'Redefinir senha',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ResetPasswordPage(loginFlow: false),
                      ),
                    );
                  },
                ),

                //Botão: Redefinir Email
                _buildWebMenuItem(
                  text: 'Redefinir e-mail',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChangeEmailPage(),
                      ),
                    );
                  },
                ),

                // Botão: Excluir Conta
                _buildWebMenuItem(
                  text: 'Excluir conta',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DeleteAccountPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          //web
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.yellow.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 110),
                    constraints: const BoxConstraints(maxWidth: 800),
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Digite seu novo nome:',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 27,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        CustomTextField(
                          labelText: 'Nome',
                          focusBorder: AppColors.yellow,
                          onChanged: (value) {
                            newName = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 55,
                          width: 700,
                          decoration: BoxDecoration(
                            border: Border.all(color: highlightColor, width: 2),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _renameUser(context, newName);
                            },
                            child: const Text(
                              'Redefinir',
                              style: TextStyle(
                                color: highlightColor,
                                fontSize: 20,
                              ),
                            ),
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
  }

  Widget _buildWebMenuItem({
    required String text,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white, width: 2)),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  //mobile
  Widget _buildMobileLayout(BuildContext context) {
    const Color highlightColor = AppColors.yellow;
    String newName = '';
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
                    AppColors.yellow.withOpacity(1.0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
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

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Digite seu novo nome:',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          labelText: 'Nome',
                          focusBorder: AppColors.yellow,
                          onChanged: (value) {
                            newName = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: highlightColor, width: 2),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _renameUser(context, newName);
                            },
                            child: const Text(
                              'Redefinir',
                              style: TextStyle(
                                color: highlightColor,
                                fontSize: 20,
                              ),
                            ),
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
  }
}
