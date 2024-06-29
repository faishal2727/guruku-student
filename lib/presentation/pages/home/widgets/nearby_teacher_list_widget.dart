// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_vertical.dart';

class NearbyTeachersListWidget extends StatelessWidget {
  final List<Teacher> teachers;

  const NearbyTeachersListWidget({Key? key, required this.teachers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 8, right: 16),
        scrollDirection: Axis.horizontal,
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: CardTeacherVertical(teacher: teachers[index]),
          );
        },
      ),
    );
  }
}
