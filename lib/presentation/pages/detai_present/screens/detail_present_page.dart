
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/detail_order/detail_order_bloc.dart';
import 'package:guruku_student/presentation/pages/detai_present/widgets/detail_present_content.dart';
import 'package:lottie/lottie.dart';

class DetailPresentPage extends StatefulWidget {
  static const ROUTE_NAME = '/order-present-page';
  final int id;

  const DetailPresentPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailPresentPage> createState() => _DetailPresentPageState();
}

class _DetailPresentPageState extends State<DetailPresentPage> {
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

  Future<void> _refresh() async {
    context.read<DetailOrderBloc>().add(OnDetailOrderEvent(widget.id));
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
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<DetailOrderBloc, DetailOrderState>(
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
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: DetailPresentContent(dataHistoryOrder: order),
              );
            } else if (state is DetailOrderEmpty) {
              return const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: EmptySection(),
              );
            } else if (state is DetailOrderError) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ErrorSection(
                  isLoading: _isLoading,
                  onPressed: _retry,
                  message: state.message,
                ),
              );
            } else {
              return const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SizedBox(),
              );
            }
          },
        ),
      ),
    );
  }
}