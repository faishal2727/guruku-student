// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/detail_order/detail_order_bloc.dart';
import 'package:guruku_student/presentation/pages/detail_order_done/widgets/order_done_content.dart';
import 'package:lottie/lottie.dart';

class DetailOrderDonePage extends StatefulWidget {
  static const ROUTE_NAME = '/order-success-page';
  final int id;

  const DetailOrderDonePage({
    super.key,
    required this.id,
  });

  @override
  State<DetailOrderDonePage> createState() => _DetailOrderDonePageState();
}

class _DetailOrderDonePageState extends State<DetailOrderDonePage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<DetailOrderBloc>().add(OnDetailOrderEvent(widget.id));
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<DetailOrderBloc>().add(OnDetailOrderEvent(widget.id));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rincian Pesanan',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
      ),
      body: BlocBuilder<DetailOrderBloc, DetailOrderState>(
        builder: (context, state) {
          if (state is DetailOrderLoading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading_state.json',
                height: 180,
                width: 180,
              ),
            );
          } else if (state is DetailOrderHasData) {
            final order = state.result;
            return OrderDoneContent(dataHistoryOrder: order);
          } else if (state is DetailOrderEmpty) {
            return const EmptySection();
          } else if (state is DetailOrderError) {
            return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
