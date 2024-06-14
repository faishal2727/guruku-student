// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/history_order_success/order_success_bloc.dart';
import 'package:guruku_student/presentation/pages/history_order/widgets/card_order_done.dart';
import 'package:lottie/lottie.dart';

class DoneOrderPage extends StatefulWidget {
  const DoneOrderPage({super.key});

  @override
  State<DoneOrderPage> createState() => _DoneOrderPageState();
}

class _DoneOrderPageState extends State<DoneOrderPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OrderSuccessBloc>().add(OnOrderSuccessEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<OrderSuccessBloc>().add(OnOrderSuccessEvent());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderSuccessBloc, OrderSuccessState>(
        builder: (context, state) {
          if (state is OrderSuccessLoading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading_state.json',
                height: 180,
                width: 180,
              ),
            );
          } else if (state is OrderSuccessHasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final order = state.result[index];
                return CardOrderDone(
                  dataHistoryOrder: order,
                );
              },
            );
          } else if (state is OrderSuccessError) {
            return ErrorSection(
              isLoading: _isLoading,
              onPressed: _retry,
              message: state.message,
            );
          } else if (state is OrderSuccessEmpty) {
            return const EmptySection();
          } else {
            return const Center(
              child: Text('Error Get History'),
            );
          }
        },
      ),
    );
  }
}
