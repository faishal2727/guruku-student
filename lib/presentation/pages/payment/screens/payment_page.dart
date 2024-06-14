import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pr11,
      appBar: AppBar(
        title: Text(
          'Pembayaran',
          style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
        ),
        backgroundColor: pr13,
        iconTheme: const IconThemeData(color: pr11),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Pembayaran',
                  style: AppTextStyle.body2.setRegular(),
                ),
                Text(
                  'Rp. 100.000',
                  style: AppTextStyle.body2.setRegular().copyWith(color: pr13),
                )
              ],
            ),
          ),
          Divider(thickness: 3, color: Colors.grey.shade200),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Batas Pembayaran',
                  style: AppTextStyle.body2.setRegular(),
                ),
                Text(
                  '2024-06-07 21:15:58',
                  style: AppTextStyle.body2.setRegular().copyWith(color: pr13),
                )
              ],
            ),
          ),
          Divider(thickness: 12, color: Colors.grey.shade200),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BRI',
                  style: AppTextStyle.body2.setRegular(),
                ),
                Divider(thickness: 2, color: Colors.grey.shade200),
                Text(
                  'Virtual Account',
                  style: AppTextStyle.body2.setRegular(),
                ),
                Text(
                  '128 085640878746',
                  style: AppTextStyle.heading4.setRegular().copyWith(color: pr13),
                )
              ],
            ),
          ),
           Divider(thickness: 12, color: Colors.grey.shade200),
        ],
      ),
    );
  }
}
