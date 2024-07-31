import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/screens/detail_tidak_page.dart';
import 'package:lottie/lottie.dart';

class CardCancelTeacher extends StatelessWidget {
  final DataHistoryOrder dataHistoryOrder;

  const CardCancelTeacher({
    super.key,
    required this.dataHistoryOrder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailTidakPage.ROUTE_NAME,
            arguments: dataHistoryOrder.id);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 16),
        decoration: const BoxDecoration(color: pr11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.store, color: pr13),
                    Text(dataHistoryOrder.student.username,
                        style: AppTextStyle.body2.setMedium()),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.danger.dng05,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text('Tidak Hadir',
                      style: AppTextStyle.body3.setMedium()),
                )
              ],
            ),
            Divider(thickness: 3, color: Colors.grey.shade100),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: dataHistoryOrder.teacher.picture != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: dataHistoryOrder.teacher.picture!,
                            fit: BoxFit.fill,
                            width: 120,
                            height: 100,
                            placeholder: (context, url) => Center(
                              child: Lottie.asset(
                                  'assets/lotties/loading_state.json',
                                  height: 60,
                                  width: 60),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.warning, color: Colors.red),
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dataHistoryOrder.teacher.name!,
                          style: AppTextStyle.body2.setMedium()),
                      Text(dataHistoryOrder.teacher.typeTeaching!,
                          style: AppTextStyle.body4.setRegular()),
                    ],
                  ),
                ),
              ],
            ),
            Divider(thickness: 3, color: Colors.grey.shade100),
            Text(
              'Total : ${dataHistoryOrder.total.toString()},',
              style: AppTextStyle.body3.setRegular(),
            ),
            Text(
              'Nama Pemesan :  ${dataHistoryOrder.onBehalf},',
              style: AppTextStyle.body3.setRegular(),
            ),
          ],
        ),
      ),
    );
  }
}
