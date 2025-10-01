import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perplexity_clone/theme/app_colors.dart';
import 'package:perplexity_clone/widgets/connection_status.dart';
import 'package:perplexity_clone/widgets/firebase_status.dart';
import 'package:perplexity_clone/widgets/search_section.dart';
import 'package:perplexity_clone/widgets/side_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          // Side Navigation
          const SideBar(),
          Expanded(
            child: Column(
              children: [
                const ConnectionStatus(),
                const FirebaseStatus(),
                const Expanded(child: SearchSection()),
                // footer
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Pro",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Enterprise",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Store",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Blog",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Careers",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Education",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "English (English)",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                    ],
                  ),
                ),
                // footer
              ],
            ),
          ),
        ],
      ),
    );
  }
}
