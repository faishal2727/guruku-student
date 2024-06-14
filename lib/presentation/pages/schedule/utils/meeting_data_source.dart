
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guruku_student/presentation/pages/schedule/utils/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    // Assume the meeting lasts for 1 hour for simplicity
    return appointments![index].from.add(Duration(hours: 1));
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    // Use a default color as the model no longer has a color property
    return Colors.blue;
  }

  @override
  bool isAllDay(int index) {
    // Assume none of the meetings are all day for simplicity
    return false;
  }
}
