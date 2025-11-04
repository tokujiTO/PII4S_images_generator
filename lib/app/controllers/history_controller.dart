import 'package:flutter/material.dart';

class HistoryController extends ChangeNotifier {
  List<String> historyItems = [];

  void addHistoryItem(String item) {
    historyItems.add(item);
    notifyListeners();
  }

  void clearHistory() {
    historyItems.clear();
    notifyListeners();
  }
}
