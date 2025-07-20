import 'package:flutter/material.dart';
import 'package:perplexity_clone/screens/chat_screen.dart';
import 'package:perplexity_clone/screens/home_screen.dart';
import 'package:perplexity_clone/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkThemeMode,
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
