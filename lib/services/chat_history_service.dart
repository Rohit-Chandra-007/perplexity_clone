import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/chat_models.dart';
import 'local_storage_service.dart';

class ChatHistoryService {
  static const String _collectionName = 'chat_history';
  static const int _maxHistoryItems = 50;
  
  // For demo purposes, using a simple user ID. In production, use proper authentication
  static const String _userId = 'demo_user';
  
  static bool _useFirebase = true;

  static CollectionReference get _collection =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .collection(_collectionName);

  static Future<List<ChatMessage>> loadHistory() async {
    if (_useFirebase) {
      try {
        final querySnapshot = await _collection
            .orderBy('timestamp', descending: true)
            .limit(_maxHistoryItems)
            .get();

        return querySnapshot.docs
            .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ChatMessage.fromJson({
                ...data,
                'timestamp': (data['timestamp'] as Timestamp).toDate().toIso8601String(),
              });
            })
            .toList();
      } catch (e) {
        if (kDebugMode) {
          print('Firebase error, falling back to local storage: $e');
        }
        _useFirebase = false;
        return await LocalStorageService.loadHistory();
      }
    } else {
      return await LocalStorageService.loadHistory();
    }
  }

  static Future<void> saveMessage(ChatMessage message) async {
    if (_useFirebase) {
      try {
        final messageData = message.toJson();
        // Convert DateTime to Firestore Timestamp
        messageData['timestamp'] = Timestamp.fromDate(message.timestamp);
        
        await _collection.doc(message.id).set(messageData);
        
        // Clean up old messages to keep only the most recent ones
        await _cleanupOldMessages();
      } catch (e) {
        if (kDebugMode) {
          print('Firebase error, falling back to local storage: $e');
        }
        _useFirebase = false;
        await LocalStorageService.saveMessage(message);
      }
    } else {
      await LocalStorageService.saveMessage(message);
    }
  }

  static Future<void> clearHistory() async {
    if (_useFirebase) {
      try {
        final querySnapshot = await _collection.get();
        final batch = FirebaseFirestore.instance.batch();
        
        for (final doc in querySnapshot.docs) {
          batch.delete(doc.reference);
        }
        
        await batch.commit();
      } catch (e) {
        if (kDebugMode) {
          print('Firebase error, falling back to local storage: $e');
        }
        _useFirebase = false;
        await LocalStorageService.clearHistory();
      }
    } else {
      await LocalStorageService.clearHistory();
    }
  }

  static Future<void> deleteMessage(String messageId) async {
    if (_useFirebase) {
      try {
        await _collection.doc(messageId).delete();
      } catch (e) {
        if (kDebugMode) {
          print('Firebase error, falling back to local storage: $e');
        }
        _useFirebase = false;
        await LocalStorageService.deleteMessage(messageId);
      }
    } else {
      await LocalStorageService.deleteMessage(messageId);
    }
  }

  static Future<void> _cleanupOldMessages() async {
    try {
      final querySnapshot = await _collection
          .orderBy('timestamp', descending: true)
          .get();

      if (querySnapshot.docs.length > _maxHistoryItems) {
        final batch = FirebaseFirestore.instance.batch();
        final docsToDelete = querySnapshot.docs.skip(_maxHistoryItems);
        
        for (final doc in docsToDelete) {
          batch.delete(doc.reference);
        }
        
        await batch.commit();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error cleaning up old messages: $e');
      }
    }
  }

  // Stream for real-time updates (Firebase only)
  static Stream<List<ChatMessage>> historyStream() {
    if (_useFirebase) {
      return _collection
          .orderBy('timestamp', descending: true)
          .limit(_maxHistoryItems)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ChatMessage.fromJson({
                ...data,
                'timestamp': (data['timestamp'] as Timestamp).toDate().toIso8601String(),
              });
            })
            .toList();
      });
    } else {
      // For local storage, return a stream that emits the current data once
      return Stream.fromFuture(LocalStorageService.loadHistory());
    }
  }
}