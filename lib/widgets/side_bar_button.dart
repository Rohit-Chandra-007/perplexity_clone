import 'package:flutter/material.dart';
import 'package:perplexity_clone/theme/app_colors.dart';

class SideBarButton extends StatelessWidget {
  final bool isCollasped;
  final String label;
  final IconData icon;
  const SideBarButton({
    super.key,
    required this.isCollasped,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isCollasped ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Icon(icon, color: AppColors.iconGrey, size: 20),
        ),
        isCollasped
            ? SizedBox()
            : Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
      ],
    );
  }
}
