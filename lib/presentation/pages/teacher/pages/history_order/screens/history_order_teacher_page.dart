// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/screens/order_cancel_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/screens/order_pending_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/screens/order_present_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/screens/order_success_teacher_page.dart';

class HistoryOrderTeacherPage extends StatefulWidget {
  static const ROUTE_NAME = "/order-teacher";
  final int id;
  const HistoryOrderTeacherPage({super.key, required this.id});

  @override
  State<HistoryOrderTeacherPage> createState() =>
      _HistoryOrderTeacherPageState();
}

class _HistoryOrderTeacherPageState extends State<HistoryOrderTeacherPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Mengajar Saya',
            style: AppTextStyle.heading5.setRegular(),
          ),
          backgroundColor: pr11,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'Pesanan Masuk',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Perlu Datang',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Selesai',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Tidak Hadir',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Center(child: OrderPendingTeacherPage(id: widget.id)),
            Center(child: OrderSuccessTeacherPage(id: widget.id)),
            Center(child: OrderPresentTeacherPage(id: widget.id)),
            Center(child: OrderCancelTeacherPage(id: widget.id)),
          ],
        ),
      ),
    );
  }
}
