// ignore_for_file: use_super_parameters

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/presentation/pages/detail_teacher/widgets/maps_widgets_detail.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/order_teacher/order_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/widgets/qr_present.dart';
import 'package:lottie/lottie.dart';

class OrderDoneTeacherContent extends StatefulWidget {
  final DetailHistoryOrder dataHistoryOrder;
  const OrderDoneTeacherContent({
    Key? key,
    required this.dataHistoryOrder,
  }) : super(key: key);

  @override
  State<OrderDoneTeacherContent> createState() =>
      _OrderDoneTeacherContentState();
}

class _OrderDoneTeacherContentState extends State<OrderDoneTeacherContent> {
  final TextEditingController controller = TextEditingController();
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now().toUtc(); // Waktu saat ini dalam UTC
      final meetingTime = widget.dataHistoryOrder.meetingTime!
          .toLocal()
          .subtract(const Duration(hours: 7)); // Kurangi 7 jam

      debugPrint("Waktu saat ini = $now, waktu pertemuan = $meetingTime");

      if (now.isAfter(meetingTime) || now.isAtSameMomentAs(meetingTime)) {
        debugPrint("Meeting time reached or passed. Triggering update.");
        _update();
        timer.cancel();
      } else {
        debugPrint("Meeting time not yet reached.");
      }
    });
  }

  void _update() {
    context
        .read<OrderTeacherBloc>()
        .add(OnUpdatePresentTidak(widget.dataHistoryOrder.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderTeacherBloc, OrderTeacherState>(
      listener: (context, state) {
        if (state.tidak == ReqTidak.error) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text(
                  "Gagal",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.red[400],
              ),
            );
        } else if (state.tidak == ReqTidak.loaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      },
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: widget.dataHistoryOrder.teacher.picture != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    widget.dataHistoryOrder.teacher.picture!,
                                fit: BoxFit.fill,
                                width: 120,
                                height: 100,
                                placeholder: (context, url) => Center(
                                  child: Lottie.asset(
                                      'assets/lotties/loading_state.json',
                                      height: 60,
                                      width: 60),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(Icons.error, color: Colors.red),
                                ),
                              ),
                            )
                          : const Center(
                              child: Icon(Icons.warning, color: Colors.red),
                            ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.dataHistoryOrder.teacher.name!,
                              style: AppTextStyle.body2.setMedium()),
                          Text(widget.dataHistoryOrder.teacher.typeTeaching!,
                              style: AppTextStyle.body4.setRegular()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 3, color: pr16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Pesanan',
                      style: AppTextStyle.body3.setRegular(),
                    ),
                    Text(
                      "Rp. ${widget.dataHistoryOrder.total.toString()}",
                      style: AppTextStyle.body3.setRegular(),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nama Pemesan',
                      style: AppTextStyle.body3.setRegular(),
                    ),
                    Text(
                      " ${widget.dataHistoryOrder.student.username}",
                      style: AppTextStyle.body3.setRegular(),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Waktu Pertemuan',
                      style: AppTextStyle.body3.setRegular(),
                    ),
                    Text(
                      formatDate(widget.dataHistoryOrder.meetingTime!.toIso8601String()),
                      style: AppTextStyle.body3.setRegular(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Detail Lokasi Siswa :',
                  style: AppTextStyle.body3.setSemiBold(),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MapsWidgetDetail(
                  lat: double.parse(widget.dataHistoryOrder.lat ?? '0.0'),
                  lon: double.parse(widget.dataHistoryOrder.lon ?? '0.0'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat Pemesan',
                      style: AppTextStyle.body3.setRegular(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      " ${widget.dataHistoryOrder.note}",
                      style: AppTextStyle.body3.setRegular(),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'No Hp Pemesan',
                      style: AppTextStyle.body3.setRegular(),
                    ),
                    Text(
                      " ${widget.dataHistoryOrder.phone}",
                      style: AppTextStyle.body3.setRegular(),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Email Pemesan',
                      style: AppTextStyle.body3.setRegular(),
                    ),
                    Text(
                      " ${widget.dataHistoryOrder.email}",
                      style: AppTextStyle.body3.setRegular(),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status Kehadiran Anda',
                      style: AppTextStyle.body3.setRegular(),
                    ),
                    Text(
                      " ${widget.dataHistoryOrder.kehadiran} hadir",
                      style: AppTextStyle.body3.setRegular(),
                    )
                  ],
                ),
              ),
              Divider(thickness: 8, color: pr16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Metode Pembayaran',
                        style: AppTextStyle.body2.setRegular()),
                    Text(widget.dataHistoryOrder.bank!.toUpperCase(),
                        style: AppTextStyle.body3.setRegular()),
                  ],
                ),
              ),
              Divider(thickness: 8, color: pr16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('No.Pesanan',
                            style: AppTextStyle.body3.setRegular()),
                        Text(widget.dataHistoryOrder.code!,
                            style: AppTextStyle.body3.setRegular()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Waktu Pesanan',
                            style: AppTextStyle.body3.setRegular()),
                        Text(
                            formatDate(widget.dataHistoryOrder.createdAt
                                .toIso8601String()),
                            style: AppTextStyle.body3.setRegular()),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(thickness: 8, color: pr16),
              Visibility(
                visible: false,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: TextField(
                    controller: controller
                      ..text =
                          'https://faizal.simagang.my.id/faisol/v1/user/present/${widget.dataHistoryOrder.id}',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your URL',
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Scan QR Code yang ada di akun siswa anda maksimal 15 menit setelah jam pertemuan di mulai',
                        style: AppTextStyle.body4.setRegular(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pr13,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const QrPresent();
                        }));
                      },
                      child: Text(
                        'Scan',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: pr11),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
