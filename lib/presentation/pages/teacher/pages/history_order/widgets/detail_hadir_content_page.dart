// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';

class DetailHadirContentPage extends StatefulWidget {
  final DetailHistoryOrder dataHistoryOrder;

  const DetailHadirContentPage({
    Key? key,
    required this.dataHistoryOrder,
  }) : super(key: key);

  @override
  State<DetailHadirContentPage> createState() => _DetailHadirContentPageState();
}

class _DetailHadirContentPageState extends State<DetailHadirContentPage> {
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nama Pemesan',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  "${widget.dataHistoryOrder.onBehalf}",
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
                  'Nomor Pemesan',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  "${widget.dataHistoryOrder.phone}",
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
                  'Id Transaksi',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  "${widget.dataHistoryOrder.code}",
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
                  'Status Pembayaran',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  "${widget.dataHistoryOrder.paymentStatus}",
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
                  'Metode Pembayaran',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  widget.dataHistoryOrder.bank!.toUpperCase(),
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
                  'Tanggal Pertemuan',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  formatDate(
                      widget.dataHistoryOrder.meetingTime!.toIso8601String()),
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
                  'Waktu Transaksi',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  formatDate(
                      widget.dataHistoryOrder.createdAt.toIso8601String()),
                  style: AppTextStyle.body3.setRegular(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
