import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_detail_response.dart';
class WdDetailContent extends StatelessWidget {
  final WithdrawDetailResponse data;

  const WdDetailContent({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.check_circle_outline_rounded;
    Color iconColor = Colors.green;

    if (data.status.toLowerCase() == 'pending') {
      iconData = Icons.pending;
      iconColor = Colors.orange; 
    } else if (data.status.toLowerCase() == 'rejected') {
      iconData = Icons.cancel; // Menggunakan ikon reject yang sesuai
      iconColor = Colors.red; 
    }

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 100,
              color: iconColor,
            ),
            Text(data.status, style: AppTextStyle.body1.setSemiBold()),
            Text(data.amount),
            Text(data.nameBank),
            Text(formatDate(data.updatedAt.toIso8601String())),
          ],
        ),
      ),
    );
  }
}
