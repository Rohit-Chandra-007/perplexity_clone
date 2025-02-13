import 'package:flutter/material.dart';
import 'package:perplexity_clone/theme/app_colors.dart';

class SearchBarButton extends StatefulWidget {
  final String label;
  final IconData icon;
  const SearchBarButton({super.key, required this.label, required this.icon});

  @override
  State<SearchBarButton> createState() => _SearchBarButtonState();
}

class _SearchBarButtonState extends State<SearchBarButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) => setState(() => isHovered = true),
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isHovered ? AppColors.proButton : AppColors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(widget.icon, color: AppColors.iconGrey, size: 20),
            const SizedBox(width: 10),
            Text(widget.label, style: TextStyle(color: AppColors.iconGrey)),
          ],
        ),
      ),
    );
  }
}
