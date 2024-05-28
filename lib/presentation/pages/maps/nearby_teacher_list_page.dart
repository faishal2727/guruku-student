import 'package:flutter/material.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_vertical.dart';

class NearbyTeachersListPage extends StatelessWidget {
  final List<Teacher> nearbyTeachers;

  const NearbyTeachersListPage({Key? key, required this.nearbyTeachers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Guru Terdekat'),
      ),
      body: ListView.builder(
        itemCount: nearbyTeachers.length,
        itemBuilder: (context, index) {
          final teacher = nearbyTeachers[index];
          return CardTeacherVertical(
            teacher: teacher,
          );
        },
      ),
    );
  }
}
