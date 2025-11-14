import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends ChangeNotifier {
  List<ResearchItem> researches = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchResearches() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      if (userId == null) {
        error = 'Usuário não autenticado.';
        isLoading = false;
        notifyListeners();
        return;
      }
      final uri = Uri.parse('https://polig-947071723613.southamerica-east1.run.app/home');
      final res = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}),
      );
      print(res.body);
      if (res.statusCode == 200) {
        // decoded is _Map<String, dynamic>
        final decoded = jsonDecode(res.body);
        researches = (decoded['mensagem'] as List)
            .map((item) => ResearchItem.fromJson(item))
            .toList();
      } else {
        error = 'Erro: ${res.statusCode}';
      }
    } catch (e) {
      error = 'Erro de conexão: $e';
    }
    isLoading = false;
    notifyListeners();
  }
}

class ResearchItem {
  final String id;
  final String subject;
  final String userId;
  final String imageBase64;
  final String prompt;

  ResearchItem({
    required this.id,
    required this.subject,
    required this.userId,
    required this.imageBase64,
    required this.prompt,
  });

  factory ResearchItem.fromJson(Map<String, dynamic> json) {
    return ResearchItem(
      id: json['_id']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      imageBase64: json['image']?.toString() ?? '',
      prompt: json['prompt']?.toString() ?? '',
    );
  }

  Uint8List? get imageBytes {
    if (imageBase64.isEmpty) return null;
    try {
      return base64Decode(imageBase64);
    } catch (_) {
      return null;
    }
  }
}
