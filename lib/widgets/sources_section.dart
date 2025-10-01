import 'package:flutter/material.dart';
import 'package:perplexity_clone/models/chat_models.dart';
import 'package:perplexity_clone/theme/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SourcesSection extends StatelessWidget {
  final List<SearchResult> sources;
  final bool isLoading;

  const SourcesSection({
    super.key,
    required this.sources,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.source_outlined, color: Colors.white70),
            SizedBox(width: 8),
            Text(
              "Sources",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Skeletonizer(
          enabled: isLoading,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: isLoading && sources.isEmpty
                ? List.generate(3, (index) => _buildSourceCard(
                    const SearchResult(title: 'Loading...', url: 'Loading...')))
                : sources.map((source) => _buildSourceCard(source)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSourceCard(SearchResult source) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            source.title,
            style: const TextStyle(fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            source.url,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
