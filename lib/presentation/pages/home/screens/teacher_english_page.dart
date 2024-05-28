// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/teacher_english/teacher_english_bloc.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_vertical.dart';
import 'package:guruku_student/presentation/pages/home/widgets/shimmer_card_vertical.dart';

class TeacherEnglishPage extends StatefulWidget {
  static const ROUTE_NAME = '/teacher_english';
  const TeacherEnglishPage({super.key});

  @override
  State<TeacherEnglishPage> createState() => _TeacherEnglishPageState();
}

class _TeacherEnglishPageState extends State<TeacherEnglishPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TeacherEnglishBloc>().add(OnTeacherEnglishEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<TeacherEnglishBloc>().add(OnTeacherEnglishEvent());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guru Bahasa Inggris'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: BlocBuilder<TeacherEnglishBloc, TeacherEnglishState>(
          builder: (context, state) {
            if (state is TeacherEnglishLoading) {
              return const Center(
                child: CardShimmerVertical(),
              );
            } else if (state is TeacherEnglishHasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final teacher = state.result[index];
                  return CardTeacherVertical(teacher: teacher);
                },
              );
            } else if (state is TeacherEnglishError) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else if (state is TeacherEnglishEmpty) {
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
