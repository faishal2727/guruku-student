// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';

import '../../../blocs/my_data_teacher/my_data_teacher_bloc.dart';

class MySchedulePage extends StatefulWidget {
  static const ROUTE_NAME = "/my-schedule-page";
  final MyDataTeacherResponse data;

  const MySchedulePage({
    super.key,
    required this.data,
  });

  @override
  State<MySchedulePage> createState() => _MySchedulePageState();
}

class _MySchedulePageState extends State<MySchedulePage> {
   @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MyDataTeacherBloc>().add(OnMyDataTeacherEvent(widget.data.id));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jadwal Saya',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text('List Jadwal yang sudah diinput sebelumnya :',
                style: AppTextStyle.body3.setRegular()),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.data.schedule!.length,
              itemBuilder: (context, index) {
                var schedule = widget.data.schedule![index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: pr11,
                  child: ListTile(
                    title: Text(
                      "Tanggal : ${formatDate(schedule.day.toIso8601String())}",
                      style: Theme.of(context).textTheme.bodyMedium!,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: schedule.time
                          .map((time) => Text("Jam : $time"))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
