import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/order_teacher/order_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/widgets/card_pending_teacher.dart';
import 'package:lottie/lottie.dart';

class OrderPendingTeacherPage extends StatefulWidget {
  final int id;
  const OrderPendingTeacherPage({
    super.key,
    required this.id,
  });

  @override
  State<OrderPendingTeacherPage> createState() =>
      _OrderPendingTeacherPageState();
}

class _OrderPendingTeacherPageState extends State<OrderPendingTeacherPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<OrderTeacherBloc>()
          .add(OnOrderTeacherPending());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<OrderTeacherBloc>().add(OnOrderTeacherPending());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderTeacherBloc, OrderTeacherState>(
        builder: (context, state) {
          if (state.statePending == ReqOdrTeacPen.loading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading_state.json',
                height: 180,
                width: 180,
              ),
            );
          } else if (state.statePending == ReqOdrTeacPen.loaded) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.listData!.length,
              itemBuilder: (context, index) {
                final order = state.listData![index];
                return CardPendingTeacher(dataHistoryOrder: order);
              },
            );
          } else if (state.statePending == ReqOdrTeacPen.error) {
            return ErrorSection(
              isLoading: _isLoading,
              onPressed: _retry,
              message: state.message,
            );
          } else if (state.statePending == ReqOdrTeacPen.empty) {
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
