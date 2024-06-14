import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderDoneContent extends StatefulWidget {
  final DetailHistoryOrder dataHistoryOrder;
  const OrderDoneContent({
    Key? key,
    required this.dataHistoryOrder,
  }) : super(key: key);

  @override
  State<OrderDoneContent> createState() => _OrderDoneContentState();
}

class _OrderDoneContentState extends State<OrderDoneContent> {
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
                  child:
                      Image.network(widget.dataHistoryOrder.teacher.picture!),
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
          Divider(thickness: 3, color: Colors.grey.shade100),
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
          Divider(thickness: 8, color: Colors.grey.shade100),
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
          Divider(thickness: 8, color: Colors.grey.shade100),
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
          Divider(thickness: 8, color: Colors.grey.shade100),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    'Untuk memastikan Guru datang, pastikan guru scan QR code ini',
                    style: AppTextStyle.body4.setRegular(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pr13,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  onPressed: () {
                    _showQRCodeDialog(context);
                  },
                  child: Text(
                    'Lihat QR Code',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: pr11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showQRCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Scan Me', style: AppTextStyle.body2.setSemiBold()),
                const SizedBox(height: 16.0),
                QrImageView(
                  data: controller.text,
                  size: 280,
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size(80, 80),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
