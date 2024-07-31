// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_detail_response.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/balance/screens/wd_detail_page.dart';

class CardWithdraw extends StatelessWidget {
  final WithdrawDetailResponse data;

  const CardWithdraw({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.black; 

    if (data.status.toLowerCase() == 'success') {
      statusColor = Colors.green;
    } else if (data.status.toLowerCase() == 'pending') {
      statusColor = Colors.orange;
    } else if (data.status.toLowerCase() == 'rejected') {
      statusColor = Colors.red;
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          WdDetailPage.ROUTE_NAME,
          arguments: data.id,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: pr11,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status : ${data.status}',
              style: AppTextStyle.body3.setMedium().setBold().copyWith(color: statusColor),
            ),
            Text(
              formatDate(data.createdAt.toString()),
              style: AppTextStyle.body3.setMedium(),
            ),
            const SizedBox(height: 8),
            Text(
              'Withdraw',
              style: AppTextStyle.body1.setMedium().setBold(),
            ),
            const SizedBox(height: 8),
            Text(
              data.amount,
              style: AppTextStyle.body2.setMedium(),
            ),
          ],
        ),
      ),
    );
  }
}

