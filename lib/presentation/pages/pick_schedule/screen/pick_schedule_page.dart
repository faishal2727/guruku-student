// ignore_for_file: use_super_parameters, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';
import 'package:guruku_student/presentation/pages/detail_order/screens/detail_order_page.dart';
import 'package:table_calendar/table_calendar.dart';

class PickSchedulePage extends StatefulWidget {
  static const ROUTE_NAME = "/pick-date";
  final TeacherDetail teacher;

  const PickSchedulePage({
    Key? key,
    required this.teacher,
  }) : super(key: key);

  @override
  State<PickSchedulePage> createState() => _PickSchedulePageState();
}

class _PickSchedulePageState extends State<PickSchedulePage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> events = [];

    if (widget.teacher.schedule != null) {
      for (var schedule in widget.teacher.schedule!) {
        if (schedule.day == _getDayOfWeek(day)) {
          DateTime dateTime = DateTime.parse(schedule.day);
          String formattedDate = _formatDate(dateTime);
          events.add(Event(
              schedule.day,
              formattedDate,
              schedule
                  .time)); // Menggunakan schedule.day sebagai properti title
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
            events.add(Event(
                schedule.day,
                formattedDate,
                schedule
                    .time)); // Menggunakan schedule.day sebagai properti title
          }
        }
      }
    }
    return events;
  }

  String _formatDate(DateTime dateTime) {
    String formattedDate = "${_getDayOfWeekString(dateTime.weekday)}, "
        "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return formattedDate;
  }

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

  String _getDayOfWeek(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T00:00:00.000Z';
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
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
          style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
        ),
        backgroundColor: pr13,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
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
          const SizedBox(height: 8.0),
          Divider(
            color: pr14,
          ),
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
                          Text(
                            title,
                            style: AppTextStyle.body3
                                .setSemiBold()
                                .copyWith(color: Colors.transparent),
                          ),
                          Text(
                            detailedTitle,
                            style: AppTextStyle.body3.setSemiBold(),
                          ),
                          const SizedBox(height: 16),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: times.length,
                            itemBuilder: (context, timeIndex) {
                              String time = times[timeIndex];
                              return Card(
                                color: pr13,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(
                                    "Jam $time",
                                    style: AppTextStyle.body3
                                        .setMedium()
                                        .copyWith(color: pr11),
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
                Navigator.pushNamed(context, DetailOrderPage.ROUTE_NAME);
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

class Event {
  final String title;
  final String detailedTitle;
  final List<String> time;

  const Event(this.title, this.detailedTitle, this.time);

  @override
  String toString() => title;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}
