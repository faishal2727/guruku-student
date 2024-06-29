// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/detail_teacher/detail_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/pick_schedule/screen/pick_schedule_content.dart';
import 'package:lottie/lottie.dart';

class Pick extends StatefulWidget {
  static const ROUTE_NAME = "/pick";
  
  final int id;
  const Pick({
    super.key,
    required this.id,
  });

  @override
  State<Pick> createState() => _PickState();
}

class _PickState extends State<Pick> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTeacherBloc>().add(OnDetailTeacherEvent(widget.id));
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<DetailTeacherBloc>().add(OnDetailTeacherEvent(widget.id));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTeacherBloc, DetailTeacherState>(
        builder: (context, state) {
          if (state.state == RequestStateDetail.loading) {
            return Center(
              child: Lottie.asset('assets/lotties/loading_state.json',
                  height: 180, width: 180),
            );
          } else if (state.state == RequestStateDetail.loaded) {
            final teacher = state.teacher;
            return PickScheduleContent(
              teacher: teacher!,
            );
          } else if (state.state == RequestStateDetail.empty) {
            return const Center(
              child: EmptySection(),
            );
          } else if (state.state == RequestStateDetail.error) {
            return ErrorSection(
              isLoading: _isLoading,
              onPressed: _retry,
              message: state.message,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
