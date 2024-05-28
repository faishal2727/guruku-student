// ignore_for_file: constant_identifier_names, unused_element, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/payment/payment_bloc.dart';
import 'package:guruku_student/presentation/pages/auth/widgets/my_text_form_field.dart';
import 'package:guruku_student/presentation/pages/choose_payment/screens/choose_payment_page.dart';
import 'package:guruku_student/presentation/pages/detail_order/widgets/button_payment.dart';
import 'package:flutter/material.dart';

class DetailOrderPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-order';
  const DetailOrderPage({super.key});

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedPaymentMethod = 'Transfer Bank - Bank BNI'; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesanan',
          style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
        ),
        backgroundColor: pr13,
        iconTheme: const IconThemeData(color: pr11),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
              color: pr11, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Text('Detail Pesanan',
                  style: AppTextStyle.heading5.setSemiBold()),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Nama Guru : ',
                    style: AppTextStyle.body3.setMedium(),
                  ),
                  Text(
                    'Alexa',
                    style: AppTextStyle.body3.setMedium(),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Mengajar : ',
                    style: AppTextStyle.body3.setMedium(),
                  ),
                  Text(
                    'Matematika',
                    style: AppTextStyle.body3.setMedium(),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Tanggal Pertemuan : ',
                    style: AppTextStyle.body3.setMedium(),
                  ),
                  Text(
                    'Rabu 28 Mei 2024',
                    style: AppTextStyle.body3.setMedium(),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Jam Pertemuan : ',
                    style: AppTextStyle.body3.setMedium(),
                  ),
                  Text(
                    '14.00 WIB',
                    style: AppTextStyle.body3.setMedium(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MyTextFormField(
                  labelText: 'Nama Pemesan',
                  controller: _nameController,
                  hintText: 'Masukan nama . . .',
                  lable: 'Nama Pemesan'),
              const SizedBox(height: 16),
              MyTextFormField(
                  labelText: 'Email',
                  controller: _nameController,
                  hintText: 'Masukan email . . .',
                  lable: 'Email Pemesan'),
              const SizedBox(height: 16),
              MyTextFormField(
                  labelText: 'Catatan',
                  controller: _nameController,
                  hintText: 'Masukan catatan . . .',
                  lable: 'Catatan Pemesan',
                  maxLines: 5),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.payment, color: pr13),
                  const SizedBox(width: 8),
                  Text(
                    'Metode Pembayaran',
                    style: AppTextStyle.body3.setMedium(),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      final selectedMethod = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChoosePaymentPage();
                          },
                        ),
                      );
                      if (selectedMethod != null) {
                        setState(() {
                          _selectedPaymentMethod = selectedMethod;
                        });
                      }
                    },
                    child: Text(
                      'Pilih Metode >',
                      style: AppTextStyle.body3.setMedium(),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  _selectedPaymentMethod,
                  style: AppTextStyle.body2.setBold(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color: pr11,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            height: 80,
          ),
          Expanded(
            flex: 2,
            child: ButtonPayment(
              onPressed: () {},
              title: 'Bayar Sekarang',
            ),
          ),
        ],
      ),
    );
  }
}


//   void _payment() {
//     context.read<PaymentBloc>().add(
//           DoPayment(
//             orderId: 1,
//             total: 50000,
//             name: 'Adung',
//           ),
//         );
//   }

// BlocListener<PaymentBloc, PaymentState>(
//         listener: (context, state) {
//           if (state.statePayment == RequestStatePayment.error) {
//             ScaffoldMessenger.of(context)
//               ..removeCurrentSnackBar()
//               ..showSnackBar(
//                 SnackBar(
//                   content: const Text(
//                     'Gagal Mendpatkan Token Snap',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   backgroundColor: Colors.red[400],
//                 ),
//               );
//           } else if (state.statePayment == RequestStatePayment.loaded) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text(
//                   'Berhasil Mendapatkan Token Snape !',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 backgroundColor: Colors.green,
//               ),
//             );
//           }
//         },
//         child: