// ignore_for_file: constant_identifier_names, use_super_parameters, library_private_types_in_public_api, prefer_interpolation_to_compose_strings, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/add_data_teacher/add_data_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/my_data_teacher/my_data_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_schedule/screen/my_schedule_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_schedule/widgets/button_save_schedule.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  static const ROUTE_NAME = "/schedule-page";
  final MyDataTeacherResponse data;

  const SchedulePage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Map<String, dynamic>> schedule = [];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        // Format pickedDate with explicit 'Z' for UTC timezone
        String formattedDate =
            DateFormat('yyyy-MM-ddT00:00:00.000').format(pickedDate) + 'Z';
        schedule.add({'day': formattedDate, 'time': []});
      });
    }
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        if (schedule[index]['time'].length < 3) {
          final now = DateTime.now();
          final time = DateTime(
            now.year,
            now.month,
            now.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          schedule[index]['time'].add(DateFormat.Hm().format(time));
        }
      });
    }
  }

  void _deleteDate(int index) {
    setState(() {
      schedule.removeAt(index);
    });
  }

  void _deleteTime(int dateIndex, int timeIndex) {
    setState(() {
      schedule[dateIndex]['time'].removeAt(timeIndex);
    });
  }

  void _submit() async {
    List<Map<String, dynamic>> combinedSchedule = [];

    // Add existing schedules (if any)
    if (widget.data.schedule != null) {
      combinedSchedule.addAll(widget.data.schedule!.map((schedule) => {
            'day': schedule.day.toIso8601String(),
            'time': schedule.time,
          }));
    }

    // Add new schedules from local state
    schedule.forEach((newSchedule) {
      combinedSchedule.add({
        'day': newSchedule['day'],
        'time': List<String>.from(newSchedule['time']),
      });
    });

    context.read<AddDataTeacherBloc>().add(
          OnPickSchedule(schedule: combinedSchedule),
        );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<MyDataTeacherBloc>()
          .add(OnMyDataTeacherEvent(widget.data.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Jadwal',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MySchedulePage.ROUTE_NAME,
                    arguments: widget.data);
              },
              icon: const Icon(Icons.calendar_month_outlined))
        ],
      ),
      body: BlocListener<AddDataTeacherBloc, AddDataTeacherState>(
        listener: (context, state) {
          if (state.stateSchedule == ReqStateSchedule.error) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text(
                    "Gagal",
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.red[400],
                ),
              );
          } else if (state.stateSchedule == ReqStateSchedule.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Berhasil!',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tambah Jadwal', style: AppTextStyle.body2.setSemiBold()),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: pr13,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () => _selectDate(context),
                  child: Text('Pilih Tanggal',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 14, color: Colors.white))),
              Expanded(
                child: ListView.builder(
                  itemCount: schedule.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: pr11,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Tanggal : ${formatDate(schedule[index]['day'])}"),
                                // Text('Date: (${schedule[index]['day']})'),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _deleteDate(index),
                                ),
                              ],
                            ),
                            Column(
                              children: schedule[index]['time']
                                  .asMap()
                                  .entries
                                  .map<Widget>((entry) {
                                int timeIndex = entry.key;
                                String time = entry.value;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Jam 1 : $time'),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () =>
                                          _deleteTime(index, timeIndex),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                            if (schedule[index]['time'].length < 3)
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: pr13,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  onPressed: () => _selectTime(context, index),
                                  child: Text('Tambah Jam',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: 14,
                                              color: Colors.white)))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ButtonSaveSchedule(onPressed: _submit, title: 'Simpan')
            ],
          ),
        ),
      ),
    );
  }
}




// Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('List Tanggal', style: AppTextStyle.body2.setMedium()),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: widget.data.schedule!.length,
//                 itemBuilder: (context, index) {
//                   var schedule = widget.data.schedule![index];
//                   return Card(
//                     color: pr11,
//                     child: ListTile(
//                       title: Text(formatDate(schedule.day.toIso8601String())),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Text('List Tanggal', style: AppTextStyle.body2.setMedium()),
//           ],
//         ),
//       ),