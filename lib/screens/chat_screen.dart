// --- Main Chat Screen Widget ---

import 'package:flutter/material.dart';
import 'package:perplexity_clone/theme/app_colors.dart';
import 'package:perplexity_clone/widgets/answer_section.dart';
import 'package:perplexity_clone/widgets/side_bar.dart';
import 'package:perplexity_clone/widgets/sources_section.dart';

class ChatScreen extends StatelessWidget {
  final String question;

  const ChatScreen({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideBar(),
          // --- Main Content ---
          const SizedBox(width: 100),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  spacing: 32,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Question Header ---
                    Text(
                      question,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                        height: 1.3,
                      ),
                    ),
              
                    // --- Sources Section ---
                    const SourcesSection(),
              
                    // --- Divider ---
                    const Divider(color: AppColors.cardColor, thickness: 1),
              
                    // --- Answer Section ---
                    const AnswerSection(),
                  ],
                ),
              ),
            ),
          ),
          const Placeholder(color: AppColors.background, strokeWidth: 0),
        ],
      ),
    );
  }
}
