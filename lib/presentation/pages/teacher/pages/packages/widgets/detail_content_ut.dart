import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order_package.dart';
import 'package:guruku_student/presentation/pages/detail_teacher/widgets/maps_widgets_detail.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/history_order/widgets/qr_present.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/widgets/qr_present_packages.dart';
import 'package:lottie/lottie.dart';

class DetailContentUt extends StatefulWidget {
  final DetailHistoryOrderPackage dataHistoryOrder;
  const DetailContentUt({
    Key? key,
    required this.dataHistoryOrder,
  }) : super(key: key);

  @override
  State<DetailContentUt> createState() => _DetailContentUtState();
}

class _DetailContentUtState extends State<DetailContentUt> {
  final TextEditingController controller = TextEditingController();
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    // _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int remainingSessions = widget.dataHistoryOrder.packages.sessions! -
        widget.dataHistoryOrder.sessions!.length;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat Pemesan',
                    style: AppTextStyle.body3.setRegular(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    " ${widget.dataHistoryOrder.address}",
                    style: AppTextStyle.body3.setRegular(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Jumlah Pertemuan :',
                          style: AppTextStyle.body3.setRegular()),
                      Text(widget.dataHistoryOrder.packages.sessions.toString(),
                          style: AppTextStyle.body3.setRegular()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Jam Pertemuan',
                          style: AppTextStyle.body3.setRegular()),
                      Text(widget.dataHistoryOrder.time!,
                          style: AppTextStyle.body3.setRegular()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hari Pertemuan : ",
                          style: AppTextStyle.body3.setRegular()),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: widget.dataHistoryOrder.packages.day != null &&
                                widget.dataHistoryOrder.packages.day!.isNotEmpty
                            ? Wrap(
                                direction: Axis.horizontal,
                                spacing: 8.0,
                                children: widget.dataHistoryOrder.packages.day!
                                    .map((type) {
                                  return Text(
                                    type,
                                    style: AppTextStyle.body3.setRegular(),
                                  );
                                }).toList(),
                              )
                            : Text(
                                "No teaching types available",
                                style:
                                    AppTextStyle.body3.setSemiBold().copyWith(
                                          color: AppColors.primary.pr13,
                                        ),
                              ),
                      ),
                    ],
                  ),
                  Text("Jumlah Absensi : ${widget.dataHistoryOrder.sessions!.length.toString()}"),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: remainingSessions,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const QrPresentPackages();
                            }));
                          },
                          child: Text(
                            'Absen Sekarang',
                            style: AppTextStyle.body3.setRegular().copyWith(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(thickness: 8, color: pr16),
          ],
        ),
      ),
    );
  }
}


// Visibility(
//               visible: false,
//               child: Container(
//                 margin: const EdgeInsets.all(20),
//                 child: TextField(
//                   controller: controller
//                     ..text =
//                         'https://faizal.simagang.my.id/faisol/v1/user/present/${widget.dataHistoryOrder.id}',
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Enter your URL',
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               child: Row(
//                 children: [
//                   Flexible(
//                     child: Text(
//                       'Scan QR Code yang ada di akun siswa anda maksimal 15 menit setelah jam pertemuan di mulai',
//                       style: AppTextStyle.body4.setRegular(),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: pr13,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                     ),
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return const QrPresent();
//                       }));
//                     },
//                     child: Text(
//                       'Scan',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium!
//                           .copyWith(color: pr11),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
