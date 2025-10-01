import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perplexity_clone/providers/chat_provider.dart';
import 'package:perplexity_clone/screens/chat_screen.dart';
import 'package:perplexity_clone/theme/app_colors.dart';
import 'package:perplexity_clone/utils/font_helper.dart';
import 'package:perplexity_clone/widgets/search_bar_button.dart';

class SearchSection extends ConsumerStatefulWidget {
  const SearchSection({super.key, this.isLabeled = true, this.onSubmitted});

  final bool? isLabeled;
  final Function(String)? onSubmitted;

  @override
  ConsumerState<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends ConsumerState<SearchSection> {
  final TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.isLabeled == true)
          Text(
            'What do you want to know?',
            style: FontHelper.ibmPlexMono(
              fontSize: 40,
              fontWeight: FontWeight.w400,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
        const SizedBox(height: 32),
        Container(
          width: 700,

          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.searchBarBorder, width: 1.5),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: queryController,
                  style: FontHelper.ibmPlexMono(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Ask anything...',
                    hintStyle: FontHelper.ibmPlexMono(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SearchBarButton(icon: Icons.auto_awesome, label: 'Focus'),
                    const SizedBox(width: 16),
                    SearchBarButton(
                      icon: Icons.add_circle_outline_outlined,
                      label: 'Attach',
                    ),
                    const Spacer(),
                    Consumer(
                      builder: (context, ref, child) {
                        final isLoading = ref.watch(isLoadingProvider);
                        
                        return InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: isLoading ? null : () async {
                            final query = queryController.text.trim();
                            if (query.isEmpty) return;

                            try {
                              if (widget.onSubmitted != null) {
                                widget.onSubmitted!(query);
                                queryController.clear();
                              } else {
                                // Default behavior (e.g., from HomeScreen)
                                // Send query first
                                await ref.read(chatProvider.notifier).sendQuery(query);
                                
                                // Clear input
                                queryController.clear();
                                
                                // Navigate to chat screen
                                if (context.mounted) {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(question: query),
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: ${e.toString()}'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isLoading 
                                  ? AppColors.submitButton.withOpacity(0.6)
                                  : AppColors.submitButton,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: isLoading
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.background,
                                    ),
                                  )
                                : Icon(
                                    Icons.arrow_forward,
                                    color: AppColors.background,
                                    size: 16,
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    queryController.dispose();
  }
}
