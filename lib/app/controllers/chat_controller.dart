import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poliedroimagesgenerator/app/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatController extends ChangeNotifier {
  // Estado do chat
  String? responseMessage;
  Uint8List? responseImage;
  bool isLoading = false;
  String? chatId;

  // Envia requisição POST para /chat
  Future<void> sendChat({
    required String subject,
    required String prompt,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      if (userId == null) {
        responseMessage = 'Usuário não autenticado.';
        isLoading = false;
        notifyListeners();
        return;
      }
      final uri = Env.loader.makeHttpUri('API_URL', path: '/chat')!;
      final res = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Env.loader.get('API_SECRET_KEY')}',
        },
        body: jsonEncode({
          'user_id': userId,
          'subject': subject,
          'prompt': prompt,
        }),
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        print('[DEBUG] Response data: $data');
        responseMessage = data['message']?.toString();
        final base64img = data['image_base64']?.toString();
        // Debug print for base64 image string
        if (base64img != null && base64img.isNotEmpty) {
          try {
            responseImage = base64ToImage(base64img);
          } catch (e) {
            responseImage = null;
          }
        } else {
          responseImage = null;
        }
      } else {
        responseMessage = 'Erro: ${res.statusCode}';
        responseImage = null;
      }
    } catch (e) {
      responseMessage = 'Erro de conexão: $e';
      responseImage = null;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteChat(String? chatId, BuildContext context) async {
    final uri = Env.loader.makeHttpUri('API_URL', path: '/chat')!;
    final res = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Env.loader.get('API_SECRET_KEY')}',
      },
      body: jsonEncode({'chat_id': chatId}),
    );
    if (res.statusCode == 200) {
      print('Chat deleted successfully');
      Navigator.pop(context);
    } else {
      print('Failed to delete chat: ${res.statusCode}');
    }
  }

  // Converte base64 para imagem PNG (Uint8List)
  Uint8List base64ToImage(String base64String) {
    return base64Decode(base64String);
  }
}
