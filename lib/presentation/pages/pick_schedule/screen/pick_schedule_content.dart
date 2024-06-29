// Import statements
// ignore_for_file: constant_identifier_names, use_super_parameters

import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';
import 'package:guruku_student/presentation/pages/detail_order/screens/order_content.dart';
import 'package:guruku_student/presentation/pages/pick_schedule/widgets/event.dart';
import 'package:table_calendar/table_calendar.dart';

class PickScheduleContent extends StatefulWidget {
  static const ROUTE_NAME = "/pick-date";
  final TeacherDetail teacher;

  const PickScheduleContent({
    Key? key,
    required this.teacher,
  }) : super(key: key);

  @override
  State<PickScheduleContent> createState() => _PickScheduleContentState();
}

// State dari PickScheduleContent
class _PickScheduleContentState extends State<PickScheduleContent> {
  // ValueNotifier untuk menyimpan daftar event yang dipilih
  late final ValueNotifier<List<Event>> _selectedEvents;
  // Format kalender yang digunakan, default bulan
  CalendarFormat _calendarFormat = CalendarFormat.month;
  // Mode seleksi rentang tanggal
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  // Hari yang difokuskan saat ini
  DateTime _focusedDay = DateTime.now();
  // Hari yang dipilih
  DateTime? _selectedDay;
  // Awal rentang tanggal yang dipilih
  DateTime? _rangeStart;
  // Akhir rentang tanggal yang dipilih
  DateTime? _rangeEnd;
  // Waktu yang dipilih
  String? _selectedTime;

  @override
  void initState() {
    super.initState();

    // Mengatur hari yang dipilih menjadi hari saat ini
    _selectedDay = _focusedDay;
    // Mendapatkan event untuk hari yang dipilih dan menginisialisasi _selectedEvents
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  // Mendapatkan daftar event untuk hari tertentu
  List<Event> _getEventsForDay(DateTime day) {
    List<Event> events = [];

    if (widget.teacher.schedule != null) {
      for (var schedule in widget.teacher.schedule!) {
        if (schedule.day == _getDayOfWeek(day)) {
          DateTime dateTime = DateTime.parse(schedule.day);
          String formattedDate = _formatDate(dateTime);
          List<String> times = schedule.time;
          List<String> availableTimes = [];

          for (String time in times) {
            bool isBooked = widget.teacher.histories.any((history) {
              DateTime bookedTime =
                  DateTime.parse(history.meetingTime.toString());
              bool isSameTime =
                  bookedTime.isAtSameMomentAs(dateTime.add(Duration(
                hours: int.parse(time.split(':')[0]),
                minutes: int.parse(time.split(':')[1]),
              )));
              return isSameTime && history.paymentStatus != "expired";
            });

            if (!isBooked) {
              availableTimes.add(time);
            }
          }

          if (availableTimes.isNotEmpty) {
            events.add(Event(schedule.day, formattedDate, availableTimes));
          }
        }
      }
    }
    return events;
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    List<Event> events = [];

    if (widget.teacher.schedule != null) {
      for (var day in daysInRange(start, end)) {
        for (var schedule in widget.teacher.schedule!) {
          if (schedule.day == _getDayOfWeek(day)) {
            DateTime dateTime = DateTime.parse(schedule.day);
            String formattedDate = _formatDate(dateTime);
            List<String> times = schedule.time;
            List<String> availableTimes = [];

            for (String time in times) {
              bool isBooked = widget.teacher.histories.any((history) {
                DateTime bookedTime =
                    DateTime.parse(history.meetingTime.toString());
                bool isSameTime =
                    bookedTime.isAtSameMomentAs(dateTime.add(Duration(
                  hours: int.parse(time.split(':')[0]),
                  minutes: int.parse(time.split(':')[1]),
                )));
                return isSameTime && history.paymentStatus != "expired";
              });

              if (!isBooked) {
                availableTimes.add(time);
              }
            }

            if (availableTimes.isNotEmpty) {
              events.add(Event(schedule.day, formattedDate, availableTimes));
            }
          }
        }
      }
    }
    return events;
  }

  // Memformat tanggal menjadi string dengan format tertentu
  String _formatDate(DateTime dateTime) {
    String formattedDate = "${_getDayOfWeekString(dateTime.weekday)}, "
        "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return formattedDate;
  }

  // Mendapatkan nama hari dalam bahasa Indonesia
  String _getDayOfWeekString(int day) {
    switch (day) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return 'Jumat';
      case 6:
        return 'Sabtu';
      case 7:
        return 'Minggu';
      default:
        return '';
    }
  }

  // Mendapatkan string hari dari objek DateTime
  String _getDayOfWeek(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T00:00:00.000Z';
  }

  // Fungsi yang dijalankan saat hari dipilih
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
        _selectedTime = null; // Reset waktu yang dipilih saat hari berubah
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  // Fungsi yang dijalankan saat rentang tanggal dipilih
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
      _selectedTime =
          null; // Reset waktu yang dipilih saat rentang tanggal berubah
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pilih Pertemuan',
          style: AppTextStyle.heading5.setSemiBold(),
        ),
        backgroundColor: pr11,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            color: pr11,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TableCalendar<Event>(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                  markerDecoration: BoxDecoration(
                    color: kRed,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: pr13,
                    shape: BoxShape.circle,
                  ),
                  disabledDecoration: BoxDecoration(
                    color: Color.fromARGB(19, 158, 158, 158),
                    shape: BoxShape.circle,
                  ),
                ),
                enabledDayPredicate: (day) {
                  return !day.isBefore(DateTime.now());
                },
                onDaySelected: _onDaySelected,
                onRangeSelected: _onRangeSelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
          ),

          Divider(
            color: pr14,
          ),
          Visibility(
            visible: false,
            child: Column(
              children: widget.teacher.histories.map((history) {
                return Text(history.meetingTime.toString());
              }).toList(),
            ),
          ),

          // Menampilkan daftar event yang dipilih

          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    Event event = value[index];
                    String title = event.title;
                    String detailedTitle = event.detailedTitle;
                    List<String> times = event.time;

                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: false,
                            child: Text(
                              title,
                              style: AppTextStyle.body3
                                  .setSemiBold()
                                  .copyWith(color: Colors.transparent),
                            ),
                          ),
                          Text(
                            'Waktu yang tesedia :',
                            style: AppTextStyle.body2.setSemiBold(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            detailedTitle,
                            style: AppTextStyle.body3.setSemiBold(),
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: times.length,
                            itemBuilder: (context, timeIndex) {
                              String time = times[timeIndex];
                              bool isBooked =
                                  widget.teacher.histories.any((history) {
                                DateTime bookedTime = DateTime.parse(
                                    history.meetingTime.toString());
                                bool isSameTime = bookedTime.isAtSameMomentAs(
                                  _selectedDay!.add(Duration(
                                    hours: int.parse(time.split(':')[0]),
                                    minutes: int.parse(time.split(':')[1]),
                                  )),
                                );
                                return isSameTime &&
                                    history.paymentStatus != "expired";
                              });
                              bool isSelected = _selectedTime == time;

                              return Card(
                                color: isSelected
                                    ? pr13
                                    : (isBooked
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade100),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: ListTile(
                                  onTap: () {
                                    if (!isBooked) {
                                      setState(() {
                                        _selectedTime = time;
                                      });
                                    }
                                  },
                                  title: Text(
                                    "Jam $time",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          color: isBooked
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Tombol navigasi untuk memilih jadwal
      bottomNavigationBar: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: pr11,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            height: 80,
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                if (_selectedDay != null && _selectedTime != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderContent(
                        teacher: widget.teacher,
                        date: _selectedDay!,
                        time: _selectedTime!,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a date and time.'),
                    ),
                  );
                }
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary.pr13,
                ),
                child: Center(
                  child: Text(
                    'Pilih Jadwal',
                    style: AppTextStyle.body1
                        .setRegular()
                        .copyWith(color: AppColors.primary.pr11),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
