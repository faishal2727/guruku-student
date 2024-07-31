import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/cancel_order_page.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/canceled_order_page.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/done_order_page.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/pending_order_page.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/present_page.dart';
import 'package:guruku_student/presentation/pages/history_order/screens/tidak_hadir_page.dart';

class HistoryOrderPage extends StatefulWidget {
  static const ROUTE_NAME = '/history-order';
  final int initialIndex;
  const HistoryOrderPage({super.key, required this.initialIndex});

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initialIndex,
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pesanan Saya',
            style: AppTextStyle.heading5.setRegular(),
          ),
          backgroundColor: pr11,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: pr13,
            physics: const NeverScrollableScrollPhysics(),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: <Widget>[
              Tab(
                  child: Text('Belum dibayar',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 12))),
              Tab(
                  child: Text('Sudah Dibayar',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 12))),
              Tab(
                  child: Text('Selesai',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 12))),
              Tab(
                  child: Text('Tidak Hadir',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 12))),
              Tab(
                  child: Text('Tidak Bayar',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 12))),
              Tab(
                  child: Text('Dibatalkan',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 12))),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(child: PendingOrderPage()),
            Center(child: DoneOrderPage()),
            Center(child: PresentPage()),
            Center(child: TidakHadirPage()),
            Center(child: ListMeetingPage()),
            Center(child: CanceledOrderPage()),
          ],
        ),
      ),
    );
  }
}
