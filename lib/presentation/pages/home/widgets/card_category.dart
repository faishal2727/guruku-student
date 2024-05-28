import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';

class CardCategory extends StatelessWidget {
  final String category;
  final IconData icons;
  const CardCategory({super.key, required this.category, required this.icons});

  @override
  Widget build(BuildContext context) {
    return Column(
  children: [
    Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.primary.pr14,
      ),
      child: Icon(
        icons,
        color: AppColors.primary.pr13,
        size: 25,
      ),
    ),
    const SizedBox(height: 8),
    Text(
      category,
      style: AppTextStyle.body4.setSemiBold(),
    )
  ],
);

  }
}
