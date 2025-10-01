import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../firebase_options.dart';

class FirebaseService {
  static bool _isInitialized = false;
  static bool _isDemo = false; // Set to false when using real Firebase project

  static bool get isInitialized => _isInitialized;
  static bool get isDemo => _isDemo;

  static Future<bool> initialize() async {
    try {
      if (_isDemo) {
        if (kDebugMode) {
          print('🔥 Firebase: Running in DEMO mode - using local storage fallback');
        }
        _isInitialized = false;
        return false;
      }

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      
      _isInitialized = true;
      if (kDebugMode) {
        print('🔥 Firebase: Initialized successfully');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('🔥 Firebase: Not available - using local storage fallback');
      }
      _isInitialized = false;
      return false;
    }
  }

  static void setDemoMode(bool demo) {
    _isDemo = demo;
  }
}