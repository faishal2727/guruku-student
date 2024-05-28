import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';

class HeaderHomeWidget extends StatelessWidget {
  const HeaderHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello !!!',
              style: AppTextStyle.body2.setMedium(),
            ),
            Text(
              'Selamat Datang',
              style: AppTextStyle.heading5
                  .setSemiBold()
                  .copyWith(color: AppColors.primary.pr13),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.pr13,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Badge(
            label: Text(
              '10',
              style: AppTextStyle.body4.setRegular(),
            ),
            child: Icon(
              Icons.notifications,
              size: 28,
              color: AppColors.primary.pr11,
            ),
          ),
        )
      ],
    );
  }
}
