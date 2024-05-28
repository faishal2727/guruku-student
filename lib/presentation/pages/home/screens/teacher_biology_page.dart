// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/teacher_biology/teacher_biology_bloc.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_vertical.dart';
import 'package:guruku_student/presentation/pages/home/widgets/shimmer_card_vertical.dart';

class TeacherBiologyPage extends StatefulWidget {
  static const ROUTE_NAME = '/teacher_biology';
  const TeacherBiologyPage({super.key});

  @override
  State<TeacherBiologyPage> createState() => _TeacherBiologyPageState();
}

class _TeacherBiologyPageState extends State<TeacherBiologyPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TeacherBiologyBloc>().add(OnTeacherBiologyEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<TeacherBiologyBloc>().add(OnTeacherBiologyEvent());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guru Bahasa Biology'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: BlocBuilder<TeacherBiologyBloc, TeacherBiologyState>(
          builder: (context, state) {
            if (state is TeacherBiologyLoading) {
              return const Center(
                child: CardShimmerVertical(),
              );
            } else if (state is TeacherBiologyHasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final teacher = state.result[index];
                  return CardTeacherVertical(teacher: teacher);
                },
              );
            } else if (state is TeacherBiologyError) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else if (state is TeacherBiologyEmpty) {
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
