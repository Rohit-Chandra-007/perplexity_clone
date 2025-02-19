import 'package:flutter/material.dart';
import 'package:perplexity_clone/services/chat_web_service.dart';
import 'package:perplexity_clone/theme/app_colors.dart';
import 'package:perplexity_clone/widgets/search_section.dart';
import 'package:perplexity_clone/widgets/side_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fullResponse = '';
  @override
  void initState() {
    super.initState();
    ChatWebService().connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side Navigation
          SideBar(),
          Expanded(
            child: Column(
              children: [
                Expanded(child: SearchSection()),
                // footer
                StreamBuilder(
                  stream: ChatWebService().contentStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    fullResponse += snapshot.data?['data'] ?? "";
                    return Text(fullResponse);
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Pro",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Enterprise",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Store",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Blog",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Careers",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Education",
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.footerGrey),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
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
