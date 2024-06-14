// import 'package:flutter/material.dart';
// import 'package:guruku_student/common/constants.dart';
// import 'package:guruku_student/common/themes/themes.dart';
// import 'package:guruku_student/presentation/pages/schedule/schedule_page.dart';

// class ScheduleDetailPage extends StatelessWidget {
//   final Meeting meeting;

//   const ScheduleDetailPage({super.key, required this.meeting});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(
//           'Detail Pertemuan',
//           style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
//         ),
//         backgroundColor: pr13,
//         iconTheme: const IconThemeData(color: pr11),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               meeting.eventName,
//               style: AppTextStyle.heading5.setSemiBold(),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Jam & Tanggal : ${meeting.from}',
//               style: AppTextStyle.body2.setRegular(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
