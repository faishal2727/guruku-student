import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/presentation/blocs/detail_teacher/detail_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/pick_schedule/screen/pick_schedule_page.dart';
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
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTeacherBloc>().add(OnDetailTeacherEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTeacherBloc, DetailTeacherState>(
        builder: (context, state) {
          if (state is DetailTeacherLoading) {
            return Center(
              child: Lottie.asset('assets/lotties/loading_state.json',
                  height: 180, width: 180),
            );
          } else if (state is DetailTeacherHasData) {
            final teacher = state.result;
            return PickSchedulePage(
              teacher: teacher,
            );
          } else if (state is DetailTeacherEmpty) {
            return const Text(
              'empty',
              key: Key('empty_message'),
            );
          } else {
            return const Text(
              'error',
              key: Key('error_message'),
            );
          }
        },
      ),
    );
  }
}
