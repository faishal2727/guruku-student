
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/order_teacher/order_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/widgets/card_present_teacher.dart';
import 'package:lottie/lottie.dart';

class OrderPresentTeacherPage extends StatefulWidget {
  final int id;
  const OrderPresentTeacherPage({
    super.key,
    required this.id,
  });

  @override
  State<OrderPresentTeacherPage> createState() =>
      _OrderPresentTeacherPageState();
}

class _OrderPresentTeacherPageState extends State<OrderPresentTeacherPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    context.read<OrderTeacherBloc>().add(OnOrderTeacherPresent());
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<OrderTeacherBloc>().add(OnOrderTeacherSuccess());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _fetchData();
        return true;
      },
      child: Scaffold(
        body: BlocBuilder<OrderTeacherBloc, OrderTeacherState>(
          builder: (context, state) {
            if (state.stateDone == ReqOdrTeacDone.loading) {
              return Center(
                child: Lottie.asset(
                  'assets/lotties/loading_state.json',
                  height: 180,
                  width: 180,
                ),
              );
            } else if (state.stateDone == ReqOdrTeacDone.loaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.listData!.length,
                itemBuilder: (context, index) {
                  final order = state.listData![index];
                  return CardPresentTeacher(dataHistoryOrder: order);
                },
              );
            } else if (state.stateDone == ReqOdrTeacDone.error) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else if (state.stateDone == ReqOdrTeacDone.empty) {
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
