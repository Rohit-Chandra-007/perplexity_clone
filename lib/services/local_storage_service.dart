import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import '../models/chat_models.dart';

/// Local storage service for web platform (fallback when Firebase is not available)
class LocalStorageService {
  static const String _historyKey = 'perplexity_chat_history';
  static const int _maxHistoryItems = 50;

  static Future<List<ChatMessage>> loadHistory() async {
    try {
      if (kIsWeb) {
        final historyJson = html.window.localStorage[_historyKey];
        if (historyJson != null) {
          final List<dynamic> historyList = jsonDecode(historyJson);
          return historyList
              .map((json) => ChatMessage.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
      return [];
    } catch (e) {
      if (kDebugMode) {
        print('Error loading chat history from local storage: $e');
      }
      return [];
    }
  }

  static Future<void> saveMessage(ChatMessage message) async {
    try {
      if (kIsWeb) {
        final currentHistory = await loadHistory();
        
        // Add new message to the beginning
        currentHistory.insert(0, message);
        
        // Keep only the most recent messages
        if (currentHistory.length > _maxHistoryItems) {
          currentHistory.removeRange(_maxHistoryItems, currentHistory.length);
        }
        
        final historyJson = jsonEncode(
          currentHistory.map((msg) => msg.toJson()).toList(),
        );
        
        html.window.localStorage[_historyKey] = historyJson;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving chat history to local storage: $e');
      }
    }
  }

  static Future<void> clearHistory() async {
    try {
      if (kIsWeb) {
        html.window.localStorage.remove(_historyKey);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing chat history from local storage: $e');
      }
    }
  }

  static Future<void> deleteMessage(String messageId) async {
    try {
      if (kIsWeb) {
        final currentHistory = await loadHistory();
        currentHistory.removeWhere((msg) => msg.id == messageId);
        
        final historyJson = jsonEncode(
          currentHistory.map((msg) => msg.toJson()).toList(),
        );
        
        html.window.localStorage[_historyKey] = historyJson;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting message from local storage: $e');
      }
    }
  }
}