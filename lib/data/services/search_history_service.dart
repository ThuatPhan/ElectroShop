import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class SearchHistoryService {
  static const _keySearchHistory = 'search_history';

  static Future<void> saveSearchKeyword(String keyword) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searchHistory = prefs.getStringList(_keySearchHistory) ?? [];

    var uuid = const Uuid();
    String id = uuid.v4();

    Map<String, String> searchItem = {
      'id': id,
      'keyword': keyword,
    };

    String searchItemJson = jsonEncode(searchItem);

    searchHistory.add(searchItemJson);

    await prefs.setStringList(_keySearchHistory, searchHistory);
  }

  static Future<List<Map<String, String>>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> storedHistory = prefs.getStringList(_keySearchHistory) ?? [];

    return storedHistory.map((item) {
      return Map<String, String>.from(jsonDecode(item));
    }).toList();
  }

  static Future<void> removeSearchKeyword(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searchHistory = prefs.getStringList(_keySearchHistory) ?? [];

    searchHistory.removeWhere((item) {
      final decodedItem = jsonDecode(item);
      return decodedItem['id'] == id;
    });

    await prefs.setStringList(_keySearchHistory, searchHistory);
  }

  static Future<void> clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keySearchHistory);
  }
}
