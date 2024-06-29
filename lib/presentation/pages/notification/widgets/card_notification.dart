import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/notif/notif_response.dart';

class CardNotification extends StatelessWidget {
  final NotifResponse data;
  const CardNotification({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(16),
      color: pr11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.title, style: AppTextStyle.body3.setBold()),
          const SizedBox(height: 4),
          Text(data.desc, style: AppTextStyle.body4.setMedium())
        ],
      ),
    );
  }
}
