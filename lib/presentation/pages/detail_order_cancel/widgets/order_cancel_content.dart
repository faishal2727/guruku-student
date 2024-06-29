import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:lottie/lottie.dart';

class OrderCancelContent extends StatelessWidget {
  final DetailHistoryOrder dataHistoryOrder;
  const OrderCancelContent({
    super.key,
    required this.dataHistoryOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: const EdgeInsets.only(top: 4),
          color: pr11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pembatalan Berhasil',
                    style:
                        AppTextStyle.heading5.setMedium().copyWith(color: pr13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Pada ${formatDate(dataHistoryOrder.updatedAt.toIso8601String())}",
                    style: AppTextStyle.body4.setMedium(),
                  ),
                ],
              ),
              const Icon(
                Icons.check_circle_outline_outlined,
                color: pr13,
                size: 50,
              )
            ],
          ),
        ),
        Divider(thickness: 1, color: pr16),
        Container(
          color: pr11,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
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
                              errorWidget: (context, url, error) =>
                                  const Center(
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
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text("Rp ${dataHistoryOrder.total}",
                              style: AppTextStyle.body4.setRegular()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Diminta oleh',
                      style: AppTextStyle.body4
                          .setMedium()
                          .copyWith(color: AppColors.neutral.ne04)),
                  Text('Guruku',
                      style: AppTextStyle.body4
                          .setMedium()
                          .copyWith(color: AppColors.neutral.ne04))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Diminta pada',
                      style: AppTextStyle.body4
                          .setMedium()
                          .copyWith(color: AppColors.neutral.ne04)),
                  Text(formatDate(dataHistoryOrder.updatedAt.toIso8601String()),
                      style: AppTextStyle.body4
                          .setMedium()
                          .copyWith(color: AppColors.neutral.ne04))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Alasan',
                      style: AppTextStyle.body4
                          .setMedium()
                          .copyWith(color: AppColors.neutral.ne04)),
                  Text('Tidak ada pembayaran',
                      style: AppTextStyle.body4
                          .setMedium()
                          .copyWith(color: AppColors.neutral.ne04))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Metode pembayaran',
                      style: AppTextStyle.body4
                          .setMedium()
                          .copyWith(color: AppColors.neutral.ne04)),
                  Text(dataHistoryOrder.bank!.toUpperCase(),
                      style: AppTextStyle.body4
                          .setMedium()
                          .copyWith(color: AppColors.neutral.ne04))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
