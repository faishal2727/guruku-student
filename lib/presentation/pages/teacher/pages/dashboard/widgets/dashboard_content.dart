import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/order_teacher/order_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_schedule/screen/schedule_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/add_teacher/screens/teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/balance/screens/balance_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/screens/history_order_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/screens/add_packages_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/screens/history_package_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/screens/my_packages_page.dart';

class DashboardContent extends StatefulWidget {
  final MyDataTeacherResponse data;
  const DashboardContent({
    super.key,
    required this.data,
  });

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OrderTeacherBloc>().add(OnOrderTeacherSuccess());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: pr11,
            child: Text("Selamat Datang ${widget.data.name}",
                style: AppTextStyle.body1.setSemiBold()),
          ),
          Divider(thickness: 2, color: pr16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Satatus Pesanan',
                        style: AppTextStyle.body3.setMedium()),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, HistoryOrderTeacherPage.ROUTE_NAME,
                              arguments: widget.data.id);
                        },
                        child: Text('Riwayat Pesanan >',
                            style: AppTextStyle.body4.setMedium())),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocBuilder<OrderTeacherBloc, OrderTeacherState>(
                      builder: (context, state) {
                        int dataCount = 0;
                        if (state.stateSuccess == ReqOdrTeacSuc.loaded) {
                          dataCount = state.listData!.length;
                        }
                        return Column(
                          children: [
                            dataCount > 0
                                ? Text(dataCount.toString(),
                                    style: AppTextStyle.heading4.setMedium())
                                : Text('0',
                                    style: AppTextStyle.heading4.setMedium()),
                            Text('Perlu Datang',
                                style: AppTextStyle.body4.setMedium()),
                          ],
                        );
                      },
                    ),
                    Column(
                      children: [
                        Text('0', style: AppTextStyle.heading4.setMedium()),
                        Text('Selesai', style: AppTextStyle.body4.setMedium()),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(thickness: 2, color: pr16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, TeacherPage.ROUTE_NAME,
                              arguments: widget.data);
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: pr13,
                              ),
                              child: const Icon(
                                Icons.personal_injury,
                                color: pr11,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Data Guru Saya',
                                style: AppTextStyle.body4.setMedium()),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, SchedulePage.ROUTE_NAME,
                              arguments: widget.data);
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: pr13,
                              ),
                              child: const Icon(
                                Icons.calendar_month,
                                color: pr11,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Jadwal',
                                style: AppTextStyle.body4.setMedium()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, BalanceTeacherPage.ROUTE_NAME,
                              arguments: widget.data);
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: pr13,
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet,
                                color: pr11,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Keuangan',
                                style: AppTextStyle.body4.setMedium()),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AddPackagesPage.ROUTE_NAME);
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: pr13,
                              ),
                              child: const Icon(
                                Icons.book,
                                color: pr11,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Tambah Paket',
                                style: AppTextStyle.body4.setMedium()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MyPackagesPage.ROUTE_NAME);
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: pr13,
                              ),
                              child: const Icon(
                                Icons.book,
                                color: pr11,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('List Paket',
                                style: AppTextStyle.body4.setMedium()),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, HistoryPackageTeacherPage.ROUTE_NAME);
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: pr13,
                              ),
                              child: const Icon(
                                Icons.book,
                                color: pr11,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('List Order Paket',
                                style: AppTextStyle.body4.setMedium()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
