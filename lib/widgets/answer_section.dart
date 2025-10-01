import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:perplexity_clone/theme/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnswerSection extends StatelessWidget {
  final String answer;
  final bool isLoading;
  final bool isStreaming;

  const AnswerSection({
    super.key,
    required this.answer,
    required this.isLoading,
    required this.isStreaming,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Answer',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Skeletonizer(
          enabled: isLoading,
          child: Markdown(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            selectable: true,
            data: answer.isEmpty && isLoading 
                ? 'Loading answer...' 
                : answer,
          ),
        ),
        if (isStreaming)
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: const Row(
              children: [
                SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Generating response...',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 24),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.thumb_up_outlined,
                color: AppColors.textSecondary,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.thumb_down_outlined,
                color: AppColors.textSecondary,
              ),
              onPressed: () {},
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.share, color: AppColors.textSecondary),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.copy, color: AppColors.textSecondary),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
