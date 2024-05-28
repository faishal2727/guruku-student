import 'package:flutter/cupertino.dart';
import 'package:guruku_student/common/themes/themes.dart';

class DataUserWidget extends StatelessWidget {
  final String title;
  final String desc;
  const DataUserWidget({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.body2.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          desc,
          style: AppTextStyle.body3,
        ),
        const SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 0.5,
          color: AppColors.primary.pr13,
        )
      ],
    );
  }
}
