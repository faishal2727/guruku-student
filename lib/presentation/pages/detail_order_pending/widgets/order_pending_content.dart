import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/presentation/blocs/order/order_bloc.dart';
import 'package:guruku_student/presentation/pages/detail_order_pending/utils/payment_utils.dart';
import 'package:guruku_student/presentation/pages/detail_order_pending/widgets/button_cancel.dart';

class OrderPendingContent extends StatefulWidget {
  final DetailHistoryOrder dataHistoryOrder;
  const OrderPendingContent({
    super.key,
    required this.dataHistoryOrder,
  });

  @override
  State<OrderPendingContent> createState() => _OrderPendingContentState();
}

class _OrderPendingContentState extends State<OrderPendingContent> {
  Map<String, dynamic>? _paymentMethods;

  @override
  void initState() {
    super.initState();
    loadPaymentMethods().then((value) {
      setState(() {
        _paymentMethods = value;
      });
    });
  }

  void _order() {
    context
        .read<OrderBloc>()
        .add(DoCancel(code: widget.dataHistoryOrder.code.toString()));
  }

  @override
  Widget build(BuildContext context) {
    if (_paymentMethods == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(thickness: 2, color: pr16),
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
                    "Rp. ${widget.dataHistoryOrder.total}",
                    style:
                        AppTextStyle.body2.setRegular().copyWith(color: pr13),
                  )
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
                    'Batas Pembayaran',
                    style: AppTextStyle.body2.setRegular(),
                  ),
                  Text(
                    formatDate(
                      widget.dataHistoryOrder.expired!.add(const Duration(hours: 7)).toString(),
                    ),
                    style:
                        AppTextStyle.body2.setRegular().copyWith(color: pr13),
                  )
                ],
              ),
            ),
            Divider(thickness: 12, color: pr16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.dataHistoryOrder.bank!.toUpperCase(),
                          style: AppTextStyle.body1.setMedium(),
                        ),
                        Divider(thickness: 2, color: pr16),
                        Text(
                          'Nomor Pembayaran',
                          style: AppTextStyle.body3.setMedium(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.dataHistoryOrder.va ?? "",
                              style: AppTextStyle.heading4
                                  .setRegular()
                                  .copyWith(color: pr13),
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: widget.dataHistoryOrder.va!));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('VA number copied to clipboard'),
                                  ),
                                );
                              },
                              child: const Icon(Icons.note_add_outlined),
                            ),
                          ],
                        ),
                        Divider(thickness: 3, color: pr16),
                        const Text(
                          'Instruksi Pembayaran :',
                          style: AppTextStyle.body2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 12, color: pr16),
            const SizedBox(height: 16),
            if (widget.dataHistoryOrder.bank != null)
              ...buildPaymentMethods(
                  context, _paymentMethods, widget.dataHistoryOrder.bank!),
            BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state.stateOrderCancel == RequestStateOrderCancel.error) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Gagal Membuat Order',
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.red[400],
                      ),
                    );
                } else if (state.stateOrderCancel ==
                    RequestStateOrderCancel.loaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Berhasil Order',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: ButtonCancel(onPressed: _order, title: 'Batalkan Pesanan'),
            ),
          ],
        ),
      );
    }
  }
}
