import 'package:flutter/material.dart';
import 'package:perplexity_clone/theme/app_colors.dart';
import 'package:perplexity_clone/widgets/side_bar_button.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool _isCollasped = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      color: AppColors.sideNav,
      width: _isCollasped ? 65 : 130,
      child: Column(
        children: [
          const SizedBox(height: 24),
          Icon(
            Icons.auto_awesome_mosaic,
            color: AppColors.whiteColor,
            size: _isCollasped ? 48 : 64,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  _isCollasped
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                SideBarButton(
                  isCollasped: _isCollasped,
                  label: "Home",
                  icon: Icons.add,
                ),
                SideBarButton(
                  isCollasped: _isCollasped,
                  label: "Search",
                  icon: Icons.search,
                ),
                SideBarButton(
                  isCollasped: _isCollasped,
                  label: "Spaces",
                  icon: Icons.language,
                ),
                SideBarButton(
                  isCollasped: _isCollasped,
                  label: "Discover",
                  icon: Icons.auto_awesome,
                ),
                SideBarButton(
                  isCollasped: _isCollasped,
                  label: "Library",
                  icon: Icons.cloud_outlined,
                ),
                const Spacer(),
              ],
            ),
          ),

          InkWell(
            onTap: () {
              setState(() {
                _isCollasped = !_isCollasped;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: Icon(
                _isCollasped
                    ? Icons.keyboard_arrow_right
                    : Icons.keyboard_arrow_left,
                color: AppColors.iconGrey,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
