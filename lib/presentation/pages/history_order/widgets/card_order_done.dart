import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/presentation/pages/detail_order_done/screens/detail_order_done_page.dart';
import 'package:lottie/lottie.dart';

class CardOrderDone extends StatelessWidget {
  final DataHistoryOrder dataHistoryOrder;

  const CardOrderDone({
    super.key,
    required this.dataHistoryOrder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailOrderDonePage.ROUTE_NAME,
          arguments: dataHistoryOrder.id,
        );
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
                    Text('Transaksi', style: AppTextStyle.body2.setMedium()),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.warning.wn04,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text('Sudah Bayar',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total ',
                  style: AppTextStyle.body3.setRegular(),
                ),
                const SizedBox(width: 4),
                Text(
                  dataHistoryOrder.total.toString(),
                  style: AppTextStyle.body3.setRegular().copyWith(color: pr13),
                )
              ],
            ),
            Divider(thickness: 3, color: Colors.grey.shade100),
            const SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text('Pastikan guru datang, dengan men scan qrcode',
                        style: AppTextStyle.body4.setRegular())),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pr13,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Konfirmasi Sekarang',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: pr11),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
