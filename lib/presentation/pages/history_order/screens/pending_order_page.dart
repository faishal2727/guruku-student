// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/history_order_pending/order_pending_bloc.dart';
import 'package:guruku_student/presentation/pages/history_order/widgets/card_order_pending.dart';
import 'package:lottie/lottie.dart';

class PendingOrderPage extends StatefulWidget {
  const PendingOrderPage({super.key});

  @override
  State<PendingOrderPage> createState() => _PendingOrderPageState();
}

class _PendingOrderPageState extends State<PendingOrderPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OrderPendingBloc>().add(OnOrderPendingEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<OrderPendingBloc>().add(OnOrderPendingEvent());
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    context.read<OrderPendingBloc>().add(OnOrderPendingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<OrderPendingBloc, OrderPendingState>(
          builder: (context, state) {
            if (state is OrderPendingLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/lotties/loading_state.json',
                  height: 180,
                  width: 180,
                ),
              );
            } else if (state is OrderPendingHasData) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  final order = state.result[index];
                  return CardOrderPending(dataHistoryOrder: order);
                },
              );
            } else if (state is OrderPendingError) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else if (state is OrderPendingEmpty) {
              return const EmptySection();
            } else {
              return const Center(
                child: Text('Error Get History'),
              );
            }
          },
        ),
      ),
    );
  }
}
