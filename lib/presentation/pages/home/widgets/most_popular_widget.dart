import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/presentation/blocs/teacher/teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_horizontal.dart';

class MostPopularWidget extends StatelessWidget {
  const MostPopularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherBloc, TeacherState>(
      builder: (context, state) {
        if (state is TeacherLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TeacherHasData) {
          final result = state.result;
          return CardTeacherHorizontal(teachers: result);
        } else if (state is TeacherError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        } else if (state is TeacherEmpty) {
          return const Center(
            child: Text(
              'empty',
              key: Key('empty_message'),
            ),
          );
        } else {
          return const Center(
            child: Text('Error Get Teacher'),
          );
        }
      },
    );
  }
}


// Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       'Paling Populer',
        //       style: AppTextStyle.body2.setSemiBold(),
        //     ),
        //     Text(
        //       'Lihat lainnya >',
        //       style: AppTextStyle.body4
        //           .setMedium()
        //           .copyWith(color: AppColors.primary.pr13),
        //     )
        //   ],
        // ),