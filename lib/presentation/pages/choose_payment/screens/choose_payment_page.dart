import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';

class ChoosePaymentPage extends StatefulWidget {
  const ChoosePaymentPage({super.key});

  @override
  State<ChoosePaymentPage> createState() => _ChoosePaymentPageState();
}

class _ChoosePaymentPageState extends State<ChoosePaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Metode Pembayaran',
          style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
        ),
        backgroundColor: pr13,
        iconTheme: const IconThemeData(color: pr11),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Metode Pembayaran',
              style: AppTextStyle.body2.setSemiBold(),
            ),
            ExpansionTile(
              title: Text(
                'Transfer Bank',
                style: AppTextStyle.body3.setMedium(),
              ),
              children: [
                ListTile(
                  title:
                      Text('Bank BNI', style: AppTextStyle.body3.setMedium()),
                  onTap: () {
                    Navigator.pop(context, 'Transfer Bank - Bank BNI');
                  },
                ),
                ListTile(
                  title:
                      Text('Bank BRI', style: AppTextStyle.body3.setMedium()),
                  onTap: () {
                    Navigator.pop(context, 'Transfer Bank - Bank BRI');
                  },
                ),
                ListTile(
                  title:
                      Text('Bank BCA', style: AppTextStyle.body3.setMedium()),
                  onTap: () {
                    Navigator.pop(context, 'Transfer Bank - Bank BCA');
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                'Agen',
                style: AppTextStyle.body3.setMedium(),
              ),
              children: [
                ListTile(
                  title:
                      Text('Indomaret', style: AppTextStyle.body3.setMedium()),
                  onTap: () {
                    Navigator.pop(context, 'Agen - Indomaret');
                  },
                ),
                ListTile(
                  title:
                      Text('Alfamart', style: AppTextStyle.body3.setMedium()),
                  onTap: () {
                    Navigator.pop(context, 'Agen - Alfamart');
                  },
                ),
                ListTile(
                  title:
                      Text('Alfamidi', style: AppTextStyle.body3.setMedium()),
                  onTap: () {
                    Navigator.pop(context, 'Agen - Alfamidi');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
