import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/cancel_order_page.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/done_order_page.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/pending_order_page.dart';

class HistoryOrderPage extends StatefulWidget {
  static const ROUTE_NAME = '/history-order';
  const HistoryOrderPage({super.key});

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pesanan Saya',
            style: AppTextStyle.heading5.setRegular(),
          ),
          backgroundColor: pr11,
          bottom: TabBar(
            indicatorColor: pr13,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Belum dibayar',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 14),
                ),
              ),
              Tab(
                child: Text(
                  'Selesai',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 14),
                ),
              ),
              Tab(
                child: Text(
                  'Dibatalkan',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(child: PendingOrderPage()),
            Center(
              child: DoneOrderPage(),
            ),
            Center(
              child: ListMeetingPage()
            ),
          ],
        ),
      ),
    );
  }
}
