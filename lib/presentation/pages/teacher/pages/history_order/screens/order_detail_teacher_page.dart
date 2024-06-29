
// ignore_for_file: use_build_context_synchronously, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/order_teacher/order_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/widgets/order_done_teacher_content.dart';
import 'package:lottie/lottie.dart';

class OrderDetailTeacherPage extends StatefulWidget {
  static const ROUTE_NAME = '/order-detail-page';
  final int idTeacher;
  final int idOrder;

  const OrderDetailTeacherPage({
    super.key,
    required this.idTeacher,
    required this.idOrder,
  });

  @override
  State<OrderDetailTeacherPage> createState() => _OrderDetailTeacherPageState();
}

class _OrderDetailTeacherPageState extends State<OrderDetailTeacherPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<OrderTeacherBloc>().add(OnOrderTeacherDetail(widget.idTeacher, widget.idOrder));
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
     context.read<OrderTeacherBloc>().add(OnOrderTeacherDetail(widget.idTeacher, widget.idOrder));
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
      body: BlocBuilder<OrderTeacherBloc, OrderTeacherState>(
        builder: (context, state) {
          if (state.stateDetail == ReqOdrTeacDetail.loading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading_state.json',
                height: 180,
                width: 180,
              ),
            );
          } else if (state.stateDetail == ReqOdrTeacDetail.loaded) {
            final order = state.detailData;
            return OrderDoneTeacherContent(dataHistoryOrder: order!);
          } else if (state.stateDetail == ReqOdrTeacDetail.empty) {
            return const EmptySection();
          } else if (state.stateDetail == ReqOdrTeacDetail.error) {
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
