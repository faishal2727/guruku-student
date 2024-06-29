import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/history_order_page.dart';

class OrderSuccessPage extends StatelessWidget {
  final List<Map<String, String>>? vaNumbers;
  final String price;
  final DateTime expired;
  final String? paymentCode;
  final String? store;

  const OrderSuccessPage({
    Key? key,
    this.vaNumbers,
    required this.price,
    required this.expired,
    this.paymentCode,
    this.store,
  }) : super(key: key);

  Future<Map<String, dynamic>> _loadPaymentInstructions() async {
    final String response =
        await rootBundle.loadString('assets/json/payment_ku.json');
    return json.decode(response);
  }

  List<Widget> _buildPaymentMethods(BuildContext context,
      Map<String, dynamic> paymentInstructions, String bank, String type) {
    List<Widget> paymentWidgets = [];
    final bankInstructions = paymentInstructions['data'].firstWhere(
      (element) =>
          element['type'] == type &&
          element['variant'].any((variant) => variant['name'] == bank),
      orElse: () => null,
    );

    if (bankInstructions != null) {
      final bankVariant = bankInstructions['variant']
          .firstWhere((variant) => variant['name'] == bank);
      final paymentMethods = bankVariant['payment_method'];

      paymentMethods.forEach((method) {
        method.forEach((methodName, steps) {
          paymentWidgets.add(
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: Column(
                children: [
                  ExpansionTile(
                    title: Text(
                      methodName,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    children: steps.map<Widget>((step) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            step,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 16),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        });
      });
    }
    return paymentWidgets;
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: Text(
        'Pembayaran',
        style: AppTextStyle.heading5.setRegular(),
      ),
      backgroundColor: pr11,
    ),
    body: FutureBuilder<Map<String, dynamic>>(
      future: _loadPaymentInstructions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading payment instructions'));
        }
        final paymentInstructions = snapshot.data!;
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                      "Rp. $price",
                      style: AppTextStyle.body2.setRegular().copyWith(color: pr13),
                    ),
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
                      expired.toString(),
                      style: AppTextStyle.body2.setRegular().copyWith(color: pr13),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 12, color: Colors.grey.shade200),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (vaNumbers != null) ...vaNumbers!.map(
                      (va) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${va['bank']}',
                                  style: AppTextStyle.body1.setMedium(),
                                ),
                                Divider(thickness: 2, color: Colors.grey.shade200),
                                Text(
                                  'Nomor Pembayaran',
                                  style: AppTextStyle.body3.setMedium(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${va['va_number']}',
                                      style: AppTextStyle.heading4.setRegular().copyWith(color: pr13),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(text: va['va_number']!));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('VA number copied to clipboard'),
                                          ),
                                        );
                                      },
                                      child: const Icon(Icons.note_add_outlined),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 3, color: Colors.grey.shade200),
                                const Text(
                                  'Instruksi Pembayaran:',
                                  style: AppTextStyle.body2,
                                ),
                                ..._buildPaymentMethods(context, paymentInstructions, va['bank']!, 'bank_transfer'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (paymentCode != null && store != null) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nomor Pembayaran',
                              style: AppTextStyle.body3.setMedium(),
                            ),
                            Divider(thickness: 2, color: Colors.grey.shade200),
                            Text(
                              paymentCode!,
                              style: AppTextStyle.heading4.setRegular().copyWith(color: pr13),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Nama Ritel',
                              style: AppTextStyle.body3.setMedium(),
                            ),
                            Divider(thickness: 2, color: Colors.grey.shade200),
                            Text(
                              store!,
                              style: AppTextStyle.heading4.setRegular().copyWith(color: pr13),
                            ),
                            Divider(thickness: 3, color: Colors.grey.shade200),
                            const Text(
                              'Instruksi Pembayaran:',
                              style: AppTextStyle.body2,
                            ),
                            ..._buildPaymentMethods(context, paymentInstructions, store!, 'cstore'),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Divider(thickness: 12, color: Colors.grey.shade200),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HistoryOrderPage.ROUTE_NAME, arguments: 1);
                },
                child: const Text('Selesai'),
              ),
            ],
          ),
        );
      },
    ),
  );
}
}