import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/presentation/pages/packages/screens/detail_packages_page.dart';

class CardPackages extends StatelessWidget {
  final Packages packages;
  const CardPackages({super.key, required this.packages});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPackagesPage.ROUTE_NAME,
            arguments: packages.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration:
            BoxDecoration(color: pr13, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(packages.name ?? "Not name",
                style: AppTextStyle.body1.setSemiBold().copyWith(color: pr11)),
            Text(packages.desc ?? "Not desc",
                style: AppTextStyle.body4.setMedium().copyWith(color: pr11))
          ],
        ),
      ),
    );
  }
}
