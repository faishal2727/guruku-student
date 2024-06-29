// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/teacher_math/teacher_math_bloc.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_horizontal.dart';
import 'package:guruku_student/presentation/pages/home/widgets/shimmer_card_hirozontal.dart';

class TeacherMathPage extends StatefulWidget {
  static const ROUTE_NAME = '/teacher_math';
  const TeacherMathPage({super.key});

  @override
  State<TeacherMathPage> createState() => _TeacherMathPageState();
}

class _TeacherMathPageState extends State<TeacherMathPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TeacherMathBloc>().add(OnTeacherMathEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<TeacherMathBloc>().add(OnTeacherMathEvent());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Guru Matematika'),
        backgroundColor: pr11,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TeacherMathBloc, TeacherMathState>(
          builder: (context, state) {
            if (state is TeacherMathLoading) {
              return const Center(
                child: ShimmerCardHorizontal(),
              );
            } else if (state is TeacherMathHasData) {
              final result = state.result;
                    return CardTeacherHorizontal(teachers: result);
            } else if (state is TeacherMathError) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else if (state is TeacherMathEmpty) {
              return const EmptySection();
            } else {
              return const Center(
                child: Text('Error Get Teacher'),
              );
            }
          },
        ),
      ),
    );
  }
}
