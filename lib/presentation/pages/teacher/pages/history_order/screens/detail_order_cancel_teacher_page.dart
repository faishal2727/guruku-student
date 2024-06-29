import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:lottie/lottie.dart';

class DetailOrderCancelTeacherPage extends StatefulWidget {
  final DetailHistoryOrder dataHistoryOrder;
  const DetailOrderCancelTeacherPage({
    Key? key,
    required this.dataHistoryOrder,
  }) : super(key: key);

  @override
  State<DetailOrderCancelTeacherPage> createState() =>
      _DetailOrderCancelTeacherPageState();
}

class _DetailOrderCancelTeacherPageState
    extends State<DetailOrderCancelTeacherPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: widget.dataHistoryOrder.teacher.picture != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: widget.dataHistoryOrder.teacher.picture!,
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
                      Text(widget.dataHistoryOrder.teacher.name!,
                          style: AppTextStyle.body2.setMedium()),
                      Text(widget.dataHistoryOrder.teacher.typeTeaching!,
                          style: AppTextStyle.body4.setRegular()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 3, color: pr16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Pesanan',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  "Rp. ${widget.dataHistoryOrder.total.toString()}",
                  style: AppTextStyle.body3.setRegular(),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nama Pemesan',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  " ${widget.dataHistoryOrder.student.username}",
                  style: AppTextStyle.body3.setRegular(),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Alamat Pemesan',
                  style: AppTextStyle.body3.setRegular(),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    widget.dataHistoryOrder.note ?? '',
                    style: AppTextStyle.body3.setRegular(),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No Hp Pemesan',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  " ${widget.dataHistoryOrder.phone}",
                  style: AppTextStyle.body3.setRegular(),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Email Pemesan',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  " ${widget.dataHistoryOrder.email}",
                  style: AppTextStyle.body3.setRegular(),
                )
              ],
            ),
          ),
          Divider(thickness: 8, color: pr16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Metode Pembayaran',
                    style: AppTextStyle.body2.setRegular()),
                Text(widget.dataHistoryOrder.bank!,
                    style: AppTextStyle.body3.setRegular()),
              ],
            ),
          ),
          Divider(thickness: 8, color: pr16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('No.Pesanan', style: AppTextStyle.body3.setRegular()),
                    Text(widget.dataHistoryOrder.code!,
                        style: AppTextStyle.body3.setRegular()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Waktu Pesanan',
                        style: AppTextStyle.body3.setRegular()),
                    Text(
                        formatDate(widget.dataHistoryOrder.createdAt
                            .toIso8601String()),
                        style: AppTextStyle.body3.setRegular()),
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 8, color: pr16),
          Visibility(
            visible: false,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: controller
                  ..text =
                      'https://faizal.simagang.my.id/faisol/v1//v1/user/present/${widget.dataHistoryOrder.id}',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your URL',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
