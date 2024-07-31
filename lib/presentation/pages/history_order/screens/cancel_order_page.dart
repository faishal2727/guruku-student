// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/history_order_cancel/order_cancel_bloc.dart';
import 'package:guruku_student/presentation/pages/history_order/widgets/card_order_cancel.dart';
import 'package:lottie/lottie.dart';

class ListMeetingPage extends StatefulWidget {
  const ListMeetingPage({super.key});

  @override
  State<ListMeetingPage> createState() => _ListMeetingPageState();
}

class _ListMeetingPageState extends State<ListMeetingPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OrderCancelBloc>().add(OnOrderCancelEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<OrderCancelBloc>().add(OnOrderCancelEvent());
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    context.read<OrderCancelBloc>().add(OnOrderCancelEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<OrderCancelBloc, OrderCancelState>(
          builder: (context, state) {
            if (state is OrderCancelLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/lotties/loading_state.json',
                  height: 180,
                  width: 180,
                ),
              );
            } else if (state is OrderCancelHasData) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  final order = state.result[index];
                  return CardOrderCancel(
                    dataHistoryOrder: order,
                  );
                },
              );
            } else if (state is OrderCancelError) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else if (state is OrderCancelEmpty) {
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
