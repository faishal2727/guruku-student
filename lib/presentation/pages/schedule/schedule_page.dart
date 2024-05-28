// ignore_for_file: constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:guruku_student/common/constants.dart';
// import 'package:guruku_student/common/themes/themes.dart';
// import 'package:guruku_student/presentation/pages/schedule/schedule_detail_page.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart';

// class SchedulePage extends StatefulWidget {
//   static const ROUTE_NAME = '/schedule_page';
//   const SchedulePage({super.key});

//   @override
//   State<SchedulePage> createState() => _SchedulePageState();
// }

// class _SchedulePageState extends State<SchedulePage> with RouteAware {
//   List<Meeting> _meetings = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadMeetingsFromJson();
//   }

//   Future<void> _loadMeetingsFromJson() async {
//     final String response = await rootBundle.loadString('assets/json/meeting.json');
//     final List<dynamic> data = jsonDecode(response);

//     setState(() {
//       _meetings = data.map((json) => Meeting.fromJson(json)).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text(
//           'Jadwal Belajar Saya',
//           style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
//         ),
//         backgroundColor: pr13,
//       ),
//       body: SfCalendar(
//         dataSource: MeetingDataSource(_meetings),
//         view: CalendarView.schedule,
//         onTap: calendarTapped,
//         scheduleViewMonthHeaderBuilder:
//             (BuildContext context, ScheduleViewMonthHeaderDetails details) {
//           final String monthName =
//               DateFormat('MMMM, yyyy').format(details.date);
//           final String backgroundImage =
//               _getBackgroundImageForMonth(details.date.month);
//           return Container(
//             height: details.bounds.height,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(backgroundImage), 
//                 fit: BoxFit.cover,
//               ),
//             ),
//             alignment: Alignment.topLeft,
//             padding: const EdgeInsets.all(10.0),
//             child: Text(
//               monthName,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 25,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           );
//         },
//         scheduleViewSettings: const ScheduleViewSettings(
//           monthHeaderSettings: MonthHeaderSettings(
//             height: 100,
//           ),
//         ),
//       ),
//     );
//   }

//   void calendarTapped(CalendarTapDetails details) {
//     if (details.targetElement == CalendarElement.appointment) {
//       final Meeting meeting = details.appointments!.first;
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ScheduleDetailPage(meeting: meeting),
//         ),
//       );
//     }
//   }

//   String _getBackgroundImageForMonth(int month) {
//     switch (month) {
//       case 1:
//         return 'assets/calender_bg/1_january_bg.jpeg';
//       case 2:
//         return 'assets/calender_bg/2_february_bg.jpeg';
//       case 3:
//         return 'assets/calender_bg/3_march_bg.jpeg';
//       case 4:
//         return 'assets/calender_bg/4_april_bg.jpeg';
//       case 5:
//         return 'assets/calender_bg/5_may_bg.jpeg';
//       case 6:
//         return 'assets/calender_bg/6_june_bg.jpeg';
//       case 7:
//         return 'assets/calender_bg/7_july_bg.jpeg';
//       case 8:
//         return 'assets/calender_bg/8_august_bg.jpeg';
//       case 9:
//         return 'assets/calender_bg/9_september_bg.jpeg';
//       case 10:
//         return 'assets/calender_bg/10_october_bg.jpeg';
//       case 11:
//         return 'assets/calender_bg/11_november_bg.jpeg';
//       case 12:
//         return 'assets/calender_bg/12_december_bg.jpeg';
//       default:
//         return 'assets/calender_bg/12_december_bg.jpeg';
//     }
//   }
// }

// class Meeting {
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color background;
//   bool isAllDay;

//   factory Meeting.fromJson(Map<String, dynamic> json) {
//     return Meeting(
//       json['eventName'] as String,
//       DateTime.parse(json['from'] as String),
//       DateTime.parse(json['to'] as String),
//       Color(int.parse(json['background'].substring(1, 7), radix: 16) + 0xFF000000),
//       json['isAllDay'] as bool,
//     );
//   }
// }

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }

//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }

//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }

//   @override
//   bool isAllDay(int index) {
//     return appointments![index].isAllDay;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class SchedulePage extends StatefulWidget {
  static const ROUTE_NAME = '/schedule_page';
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> with RouteAware {
  List<Meeting> _meetings = [];
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _loadMeetingsFromJson();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _loadMeetingsFromJson() async {
    final String response = await rootBundle.loadString('assets/json/meeting.json');
    final List<dynamic> data = jsonDecode(response);

    setState(() {
      _meetings = data.map((json) => Meeting.fromJson(json)).toList();
      _scheduleNotifications();
    });
  }

  void _scheduleNotifications() {
    for (Meeting meeting in _meetings) {
      final DateTime notificationTime = meeting.from.subtract(Duration(minutes: 2));
      _scheduleNotification(meeting.eventName, notificationTime);
    }
  }

  Future<void> _scheduleNotification(String title, DateTime scheduledTime) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      'Event starting in 1 hour',
      tzScheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Jadwal Belajar Saya',
          style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
        ),
        backgroundColor: pr13,
      ),
      body: SfCalendar(
        dataSource: MeetingDataSource(_meetings),
        view: CalendarView.schedule,
        onTap: calendarTapped,
        scheduleViewMonthHeaderBuilder:
            (BuildContext context, ScheduleViewMonthHeaderDetails details) {
          final String monthName =
              DateFormat('MMMM, yyyy').format(details.date);
          final String backgroundImage =
              _getBackgroundImageForMonth(details.date.month);
          return Container(
            height: details.bounds.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage), 
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              monthName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        },
        scheduleViewSettings: const ScheduleViewSettings(
          monthHeaderSettings: MonthHeaderSettings(
            height: 100,
          ),
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      final Meeting meeting = details.appointments!.first;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleDetailPage(meeting: meeting),
        ),
      );
    }
  }

  String _getBackgroundImageForMonth(int month) {
    switch (month) {
      case 1:
        return 'assets/calender_bg/1_january_bg.jpeg';
      case 2:
        return 'assets/calender_bg/2_february_bg.jpeg';
      case 3:
        return 'assets/calender_bg/3_march_bg.jpeg';
      case 4:
        return 'assets/calender_bg/4_april_bg.jpeg';
      case 5:
        return 'assets/calender_bg/5_may_bg.jpeg';
      case 6:
        return 'assets/calender_bg/6_june_bg.jpeg';
      case 7:
        return 'assets/calender_bg/7_july_bg.jpeg';
      case 8:
        return 'assets/calender_bg/8_august_bg.jpeg';
      case 9:
        return 'assets/calender_bg/9_september_bg.jpeg';
      case 10:
        return 'assets/calender_bg/10_october_bg.jpeg';
      case 11:
        return 'assets/calender_bg/11_november_bg.jpeg';
      case 12:
        return 'assets/calender_bg/12_december_bg.jpeg';
      default:
        return 'assets/calender_bg/12_december_bg.jpeg';
    }
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      json['eventName'] as String,
      DateTime.parse(json['from'] as String),
      DateTime.parse(json['to'] as String),
      Color(int.parse(json['background'].substring(1, 7), radix: 16) + 0xFF000000),
      json['isAllDay'] as bool,
    );
  }
}

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
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class ScheduleDetailPage extends StatelessWidget {
  final Meeting meeting;

  const ScheduleDetailPage({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Jadwal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meeting.eventName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Dari: ${meeting.from}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Sampai: ${meeting.to}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'All Day: ${meeting.isAllDay ? 'Yes' : 'No'}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
