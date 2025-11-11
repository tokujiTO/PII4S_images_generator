import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends ChangeNotifier {
  List<HistoryItem> historyItems = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchHistory() async {
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
      final uri = Uri.parse('http://127.0.0.1:5000/history');
      final res = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}),
      );
      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        historyItems = (decoded['mensagem'] as List)
            .map((item) => HistoryItem.fromJson(item))
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

class HistoryItem {
  final String id;
  final String subject;
  final String userId;
  final String imageBase64;
  final String prompt;

  HistoryItem({
    required this.id,
    required this.subject,
    required this.userId,
    required this.imageBase64,
    required this.prompt,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
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
