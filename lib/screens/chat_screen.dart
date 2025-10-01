import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perplexity_clone/models/chat_models.dart';
import 'package:perplexity_clone/providers/chat_provider.dart';
import 'package:perplexity_clone/theme/app_colors.dart';
import 'package:perplexity_clone/widgets/answer_section.dart';
import 'package:perplexity_clone/widgets/search_section.dart';
import 'package:perplexity_clone/widgets/side_bar.dart';
import 'package:perplexity_clone/widgets/sources_section.dart';

class ChatScreen extends ConsumerWidget {
  final String question;

  const ChatScreen({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    
    return Scaffold(
      body: Row(
        children: [
          const SideBar(),
          // --- Main Content ---
          const SizedBox(width: 100),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  primary: true,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: chatState.messages.map((message) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- Question Header ---
                            Text(
                              message.query,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 32),
                            // --- Sources Section ---
                            SourcesSection(
                              key: ValueKey('sources_${message.id}'),
                              sources: message.sources,
                              isLoading: message.status == ChatStatus.loading,
                            ),
                            const SizedBox(height: 32),
                            // --- Divider ---
                            const Divider(
                              color: AppColors.cardColor,
                              thickness: 1,
                            ),
                            const SizedBox(height: 32),
                            // --- Answer Section ---
                            AnswerSection(
                              key: ValueKey('answer_${message.id}'),
                              answer: message.answer,
                              isLoading: message.status == ChatStatus.loading,
                              isStreaming: message.status == ChatStatus.streaming,
                            ),
                            const SizedBox(height: 32),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // --- Floating Chat Box ---
                Positioned(
                  bottom: 4,
                  child: SearchSection(
                    isLabeled: false,
                    onSubmitted: (query) {
                      ref.read(chatProvider.notifier).sendQuery(query);
                    },
                  ),
                ),
              ],
            ),
          ),
          const Placeholder(color: AppColors.background, strokeWidth: 0),
        ],
      ),
    );
  }
}
