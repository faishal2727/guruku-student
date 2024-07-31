import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/history_order_pending/order_pending_bloc.dart';
import 'package:guruku_student/presentation/blocs/history_order_success/order_success_bloc.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/history_order_page.dart';

class MyOrderWidget extends StatefulWidget {
  const MyOrderWidget({super.key});

  @override
  State<MyOrderWidget> createState() => _MyOrderWidgetState();
}

class _MyOrderWidgetState extends State<MyOrderWidget> {
  @override
  void initState() {
    super.initState();
    context.read<OrderPendingBloc>().add(OnOrderPendingEvent());
    context.read<OrderSuccessBloc>().add(OnOrderSuccessEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pesananan Les Harian', style: AppTextStyle.body3.setMedium()),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, HistoryOrderPage.ROUTE_NAME,
                      arguments: 0);
                },
                child: Text('Lihat Riwayat Pesanan >',
                    style: AppTextStyle.body4.setMedium()),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, HistoryOrderPage.ROUTE_NAME,
                        arguments: 0);
                  },
                  child: BlocBuilder<OrderPendingBloc, OrderPendingState>(
                    builder: (context, state) {
                      int pendingCount = 0;
                      if (state is OrderPendingHasData) {
                        pendingCount = state.result.length;
                      }

                      return Column(
                        children: [
                          pendingCount > 0
                              ? Badge(
                                  label: Text(
                                    pendingCount.toString(),
                                    style: AppTextStyle.body4,
                                  ),
                                  child: Icon(
                                      Icons.account_balance_wallet_outlined,
                                      size: 40,
                                      color: Colors.grey.shade600))
                              : Icon(Icons.account_balance_wallet_outlined,
                                  size: 40, color: Colors.grey.shade600),
                          const SizedBox(height: 8),
                          const Text('Belum Bayar', style: AppTextStyle.body4)
                        ],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, HistoryOrderPage.ROUTE_NAME,
                        arguments: 1);
                  },
                  child: BlocBuilder<OrderSuccessBloc, OrderSuccessState>(
                    builder: (context, state) {
                      int pendingCount = 0;
                      if (state is OrderSuccessHasData) {
                        pendingCount = state.result.length;
                      }
                      return Column(
                        children: [
                          pendingCount > 0
                              ? Badge(
                                  label: Text(
                                    pendingCount.toString(),
                                    style: AppTextStyle.body4,
                                  ),
                                  child: Icon(Icons.check_circle_outline,
                                      size: 40, color: Colors.grey.shade600))
                              : Icon(Icons.check_circle_outline,
                                  size: 40, color: Colors.grey.shade600),
                          const SizedBox(height: 8),
                          const Text('Sudah Bayar', style: AppTextStyle.body4)
                        ],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, HistoryOrderPage.ROUTE_NAME,
                        arguments: 2);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.stars_outlined,
                          size: 40, color: Colors.grey.shade600),
                      const SizedBox(height: 8),
                      const Text('Selesai & Nilai', style: AppTextStyle.body4)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, HistoryOrderPage.ROUTE_NAME,
                        arguments: 3);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.cancel_outlined,
                          size: 40, color: Colors.grey.shade600),
                      const SizedBox(height: 8),
                      const Text('Dibatalkan', style: AppTextStyle.body4)
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
