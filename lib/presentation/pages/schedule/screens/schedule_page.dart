// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/history_order_success/order_success_bloc.dart';
import 'package:guruku_student/presentation/pages/schedule/utils/meeting.dart';
import 'package:guruku_student/presentation/pages/schedule/utils/meeting_data_source.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class SchedulePage extends StatefulWidget {
  static const ROUTE_NAME = '/schedule_page';
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> with RouteAware {
  List<Meeting> _meetings = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OrderSuccessBloc>().add(OnOrderSuccessEvent());
    });
  }

   void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<OrderSuccessBloc>().add(OnOrderSuccessEvent());
    setState(() {
      _isLoading = false;
    });
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
      body: BlocBuilder<OrderSuccessBloc, OrderSuccessState>(
        builder: (context, state) {
          if (state is OrderSuccessLoading) {
           return Center(
              child: Lottie.asset(
                'assets/lotties/loading_state.json',
                height: 180,
                width: 180,
              ),
            );
          } else if (state is OrderSuccessHasData) {
            _meetings = state.result
                .map((dataHistoryOrder) => Meeting(
                      "Les ${dataHistoryOrder.teacher.typeTeaching}",
                      dataHistoryOrder.meetingTime ?? DateTime.now(),
                    ))
                .toList();

            return SfCalendar(
              dataSource: MeetingDataSource(_meetings),
              view: CalendarView.schedule,
              scheduleViewMonthHeaderBuilder: (BuildContext context,
                  ScheduleViewMonthHeaderDetails details) {
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
            );
          } else if (state is OrderSuccessError) {
            return ErrorSection(
              isLoading: _isLoading,
              onPressed: _retry,
              message: state.message,
            );
          } else if (state is OrderSuccessEmpty) {
            return const EmptySection();
          } else {
            return const Center(
              child: Text('Error Get History'),
            );
          }
        },
      ),
    );
  }

  // void calendarTapped(CalendarTapDetails details) {
  //   if (details.targetElement == CalendarElement.appointment) {
  //     final Meeting meeting = details.appointments!.first;
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ScheduleDetailPage(meeting: meeting),
  //       ),
  //     );
  //   }
  // }

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
