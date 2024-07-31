
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/detail_order/detail_order_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/widgets/detail_tidak_content_page.dart';
import 'package:lottie/lottie.dart';

class DetailTidakPage extends StatefulWidget {
  static const ROUTE_NAME = '/order-tidak-hadir-page';
  final int id;

  const DetailTidakPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailTidakPage> createState() => _DetailTidakPageState();
}

class _DetailTidakPageState extends State<DetailTidakPage> {
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
            return DetailTidakContentPage(dataHistoryOrder: order);
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
