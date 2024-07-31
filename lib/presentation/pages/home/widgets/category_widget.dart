import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_biology_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_english_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_indonesian_page.dart';
import 'package:guruku_student/presentation/pages/home/screens/teacher_math_page.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_category.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kategori',
            style: AppTextStyle.body2.setSemiBold(),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, TeacherMathPage.ROUTE_NAME);
                  },
                  child: const CardCategory(
                    category: 'Matematika',
                    icons: Icons.numbers,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, TeacherEnglishPage.ROUTE_NAME);
                  },
                  child: const CardCategory(
                    category: 'B.Inggris',
                    icons: Icons.translate,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, TeacherBiologyPage.ROUTE_NAME);
                  },
                  child: const CardCategory(
                    category: 'B.Indonesia',
                    icons: Icons.book,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, TeacherIndonesianPage.ROUTE_NAME);
                  },
                  child: const CardCategory(
                    category: 'IPA',
                    icons: Icons.science,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, TeacherIndonesianPage.ROUTE_NAME);
                  },
                  child: const CardCategory(
                    category: 'Lainnya',
                    icons: Icons.menu,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
