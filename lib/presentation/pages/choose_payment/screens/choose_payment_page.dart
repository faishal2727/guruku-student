import 'package:flutter/material.dart';
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
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Metode Pembayaran',
              style: AppTextStyle.body2.setSemiBold(),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 2,
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  leading: const Icon(Icons.account_balance_wallet),
                  title: Text(
                    'Transfer Bank',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 16),
                  ),
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      color: AppColors.neutral.ne01,
                      elevation: 1,
                      child: ListTile(
                        leading: Image.asset("assets/payment/bni.webp"),
                        title: Text(
                          'Bank BNI',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pop(context, {
                            'name': 'Transfer Bank - Bank BNI',
                            'paymentType': 'bank_transfer',
                            'bankVa': 'bni'
                          });
                        },
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      color: AppColors.neutral.ne01,
                      elevation: 1,
                      child: ListTile(
                          leading: Image.asset("assets/payment/bri.webp", width: 38,),
                        title: Text(
                          'Bank BRI',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pop(context, {
                            'name': 'Transfer Bank - Bank BRI',
                            'paymentType': 'bank_transfer',
                            'bankVa': 'bri'
                          });
                        },
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.fromLTRB(12, 4, 12, 16),
                      color: AppColors.neutral.ne01,
                      elevation: 1,
                      child: ListTile(
                        leading: Image.asset("assets/payment/cimb.png"),
                        title: Text(
                          'Bank CIMB',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pop(context, {
                            'name': 'Transfer Bank - Bank CIMB',
                            'paymentType': 'bank_transfer',
                            'bankVa': 'cimb'
                          });
                        },
                      ),
                    ),
                    // Card(
                    //   margin: const EdgeInsets.fromLTRB(12, 4, 12, 16),
                    //   color: AppColors.neutral.ne01,
                    //   elevation: 1,
                    //   child: ListTile(
                    //     leading: Image.asset("assets/payment/bca.webp"),
                    //     title: Text(
                    //       'Bank BCA',
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyMedium!
                    //           .copyWith(fontSize: 14),
                    //     ),
                    //     onTap: () {
                    //       Navigator.pop(context, {
                    //         'name': 'Transfer Bank - Bank BCA',
                    //         'paymentType': 'bank_transfer',
                    //         'bankVa': 'bca'
                    //       });
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // Card(
            //   color: Colors.white,
            //   elevation: 2,
            //   child: Theme(
            //     data: Theme.of(context).copyWith(
            //       dividerColor: Colors.transparent,
            //     ),
            //     child: ExpansionTile(
            //       title: Text(
            //         'CSTORE',
            //         style: Theme.of(context)
            //             .textTheme
            //             .headlineSmall!
            //             .copyWith(fontSize: 16),
            //       ),
            //       children: [
            //         Card(
            //           margin: const EdgeInsets.symmetric(
            //               horizontal: 12, vertical: 4),
            //           color: AppColors.neutral.ne01,
            //           elevation: 1,
            //           child: ListTile(
            //             title: Text(
            //               'Indomaret',
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .bodyMedium!
            //                   .copyWith(fontSize: 14),
            //             ),
            //             onTap: () {
            //               Navigator.pop(context, {
            //                 'name': 'cstore - Indomaret',
            //                 'paymentType': 'cstore',
            //                 'bankVa': 'indomaret'
            //               });
            //             },
            //           ),
            //         ),
            //         Card(
            //           margin: const EdgeInsets.fromLTRB(12, 4, 12, 16),
            //           color: AppColors.neutral.ne01,
            //           elevation: 1,
            //           child: ListTile(
            //             title: Text(
            //               'Alfamart',
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .bodyMedium!
            //                   .copyWith(fontSize: 14),
            //             ),
            //             onTap: () {
            //               Navigator.pop(context, {
            //                 'name': 'cstore - Alfamart',
            //                 'paymentType': 'cstore',
            //                 'bankVa': 'alfamart'
            //               });
            //             },
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
