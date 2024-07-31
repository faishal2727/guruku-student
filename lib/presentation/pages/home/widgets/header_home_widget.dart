import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/notif/notif_bloc.dart';
import 'package:guruku_student/presentation/pages/home/screens/change_location_page.dart';
import 'package:guruku_student/presentation/pages/notification/screens/notification_page.dart';
class HeaderHomeWidget extends StatefulWidget {
  final double? userLatitude;
  final double? userLongitude;
  final String userAddress;
  final Function(double, double, String) onLocationChanged;

  const HeaderHomeWidget({
    super.key,
    this.userLatitude,
    this.userLongitude,
    required this.userAddress,
    required this.onLocationChanged,
  });

  @override
  State<HeaderHomeWidget> createState() => _HeaderHomeWidgetState();
}

class _HeaderHomeWidgetState extends State<HeaderHomeWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NotifBloc>().add(OnGetNotifEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello !!!',
                    style: AppTextStyle.body2.setMedium(),
                  ),
                  Text(
                    'Selamat Datang',
                    style: AppTextStyle.heading5
                        .setSemiBold()
                        .copyWith(color: AppColors.primary.pr13),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, NotificationPage.ROUTE_NAME);
                },
                child: BlocBuilder<NotifBloc, NotifState>(
                  builder: (context, state) {
                    int pendingCount = 0;
                    if (state.state == ReqStateNotif.loaded) {
                      pendingCount = state.listData!.length;
                    }
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.pr13,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: pendingCount > 0
                          ? Badge(
                              label: Text(
                                pendingCount.toString(),
                                style: AppTextStyle.body4.setRegular(),
                              ),
                              child: Icon(
                                Icons.notifications,
                                size: 28,
                                color: AppColors.primary.pr11,
                              ),
                            )
                          : Badge(
                              label: Text(
                                '0',
                                style: AppTextStyle.body4.setRegular(),
                              ),
                              child: Icon(
                                Icons.notifications,
                                size: 28,
                                color: AppColors.primary.pr11,
                              ),
                            ),
                    );
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text('Lokasi Anda : ${widget.userAddress}'),
          InkWell(
            onTap: () async {
              final result = await Navigator.pushNamed(context, ChangeLocationPage.ROUTE_NAME);
              if (result != null && result is Map<String, dynamic>) {
                widget.onLocationChanged(
                  result['latitude'],
                  result['longitude'],
                  result['address'],
                );
              }
            },
            child: Text('Ganti Lokasi',
                style: AppTextStyle.body3.setSemiBold().copyWith(color: AppColors.primary.pr13)),
          )
        ],
      ),
    );
  }
}
