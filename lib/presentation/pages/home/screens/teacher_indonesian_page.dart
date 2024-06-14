// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/teacher_indonesian/teacher_indo_bloc.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_vertical.dart';
import 'package:guruku_student/presentation/pages/home/widgets/shimmer_card_vertical.dart';

class TeacherIndonesianPage extends StatefulWidget {
  static const ROUTE_NAME = '/teacher_indonesian';
  const TeacherIndonesianPage({super.key});

  @override
  State<TeacherIndonesianPage> createState() => _TeacherIndonesianPageState();
}

class _TeacherIndonesianPageState extends State<TeacherIndonesianPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TeacherIndoBloc>().add(OnTeacherIndoEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<TeacherIndoBloc>().add(OnTeacherIndoEvent());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guru Bahasa Indonesia'),
         backgroundColor: pr11,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TeacherIndoBloc, TeacherIndoState>(
          builder: (context, state) {
            if (state is TeacherIndoLoading) {
              return const Center(
                child: CardShimmerVertical(),
              );
            } else if (state is TeacherIndoHasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final teacher = state.result[index];
                  return CardTeacherVertical(teacher: teacher);
                },
              );
            } else if (state is TeacherIndoError) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else if (state is TeacherIndoEmpty) {
              return const EmptySection();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
