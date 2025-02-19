import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perplexity_clone/services/chat_web_service.dart';
import 'package:perplexity_clone/theme/app_colors.dart';
import 'package:perplexity_clone/widgets/search_bar_button.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  TextEditingController queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'What do you want to know?',
          style: GoogleFonts.ibmPlexMono(
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
                  style: GoogleFonts.ibmPlexMono(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Ask anything...',
                    hintStyle: GoogleFonts.ibmPlexMono(
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
                    InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () {
                        ChatWebService().chat(queryController.text.trim());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.submitButton,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColors.background,
                          size: 16,
                        ),
                      ),
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
