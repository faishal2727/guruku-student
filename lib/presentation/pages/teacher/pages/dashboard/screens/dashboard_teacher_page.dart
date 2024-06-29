// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/my_data_teacher/my_data_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/dashboard/widgets/dashboard_content.dart';

class DashboardTeacherPage extends StatefulWidget {
  static const ROUTE_NAME = "/dasboard-teacher";
  final int id;
  const DashboardTeacherPage({
    super.key,
    required this.id,
  });

  @override
  State<DashboardTeacherPage> createState() => _DashboardTeacherPageState();
}

class _DashboardTeacherPageState extends State<DashboardTeacherPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MyDataTeacherBloc>().add(OnMyDataTeacherEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyDataTeacherBloc, MyDataTeacherState>(
      builder: (context, state) {
        if (state.state == RequestStateDetail.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == RequestStateDetail.loaded) {
          return DashboardContent(data: state.teacher!);
        } else if (state.state == RequestStateDetail.empty) {
          return const Center(
            child: Text('kosong'),
          );
        } else if (state.state == RequestStateDetail.error) {
          return const Center(
            child: Text('error'),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
