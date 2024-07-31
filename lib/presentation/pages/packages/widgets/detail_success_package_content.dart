import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order_package.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailSuccessPackageContent extends StatefulWidget {
  final DetailHistoryOrderPackage dataHistoryOrder;

  const DetailSuccessPackageContent({
    Key? key,
    required this.dataHistoryOrder,
  }) : super(key: key);

  @override
  State<DetailSuccessPackageContent> createState() =>
      _DetailSuccessPackageContentState();
}

class _DetailSuccessPackageContentState
    extends State<DetailSuccessPackageContent> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            imageUrl: widget.dataHistoryOrder.teacher.picture!,
                            fit: BoxFit.fill,
                            width: 120,
                            height: 100,
                            placeholder: (context, url) => Center(
                              child: Lottie.asset(
                                  'assets/lotties/loading_state.json',
                                  height: 60,
                                  width: 60),
                            ),
                            errorWidget: (context, url, error) => const Center(
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
                      Text(
                          "Nama Guru : ${widget.dataHistoryOrder.teacher.name!}",
                          style: AppTextStyle.body2.setSemiBold()),
                      Text("Mapel : ${widget.dataHistoryOrder.mapel}",
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
                    Text('No.Pesanan', style: AppTextStyle.body3.setRegular()),
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
                    Text('Jumlah Sesi', style: AppTextStyle.body3.setRegular()),
                    Text(widget.dataHistoryOrder.packages.sessions.toString(),
                        style: AppTextStyle.body3.setRegular()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Jam Pertemuan',
                        style: AppTextStyle.body3.setRegular()),
                    Text(widget.dataHistoryOrder.time.toString(),
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
                              style: AppTextStyle.body3.setSemiBold().copyWith(
                                    color: AppColors.primary.pr13,
                                  ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 8, color: pr16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Absensi Kehadiran Guru',
                    style: AppTextStyle.body2.setMedium()),
                for (int i = widget.dataHistoryOrder.sessions!.length + 1;
                    i <= widget.dataHistoryOrder.packages.sessions!;
                    i++)
                  GestureDetector(
                    onTap: () => _showQRCodeDialog(context, 'Absensi Sesi $i'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text('Absensi Sesi $i',
                          style: AppTextStyle.body3.setRegular().copyWith(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              )),
                    ),
                  ),
              ],
            ),
          ),
          Text("Jumlah Sessions : ${widget.dataHistoryOrder.sessions!.length}"),
          Text("Order Id : ${widget.dataHistoryOrder.id}"),
          Text("Order Id : ${widget.dataHistoryOrder.packageId}"),
        ],
      ),
    );
  }

  void _showQRCodeDialog(BuildContext context, String session) {
    String qrData =
        'Order Id: ${widget.dataHistoryOrder.id}\nPackage Id: ${widget.dataHistoryOrder.packageId}';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(session, style: AppTextStyle.body2.setSemiBold()),
                const SizedBox(height: 16.0),
                QrImageView(
                  data: qrData,
                  size: 280,
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size(80, 80),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Visibility(
          //   visible: false,
          //   child: Container(
          //     margin: const EdgeInsets.all(20),
          //     child: TextField(
          //       controller: controller
          //         ..text = widget.dataHistoryOrder.id.toString(),
          //       decoration: const InputDecoration(
          //         border: OutlineInputBorder(),
          //         labelText: 'Enter your URL',
          //       ),
          //     ),
          //   ),
          // ),
          // if (isScanButtonVisible)
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   child: Row(
          //     children: [
          //       Flexible(
          //         child: Text(
          //           'Untuk memastikan Guru datang, pastikan guru scan QR code ini',
          //           style: AppTextStyle.body4.setRegular(),
          //         ),
          //       ),
          //       const SizedBox(width: 10),
          //       ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: pr13,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           padding: const EdgeInsets.symmetric(horizontal: 20),
          //         ),
          //         onPressed: () {
          //           _showQRCodeDialog(context);
          //         },
          //         child: Text(
          //           'Lihat QR Code',
          //           style: Theme.of(context)
          //               .textTheme
          //               .bodyMedium!
          //               .copyWith(color: pr11),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // if (!isScanButtonVisible)
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   child: Row(
          //     children: [
          //       Flexible(
          //         child: Text(
          //           'Karena guru yang anda pesan tidak hadir, anda bisa mengajukan uang transaksi anda',
          //           style: AppTextStyle.body4.setRegular(),
          //         ),
          //       ),
          //       const SizedBox(width: 10),
          //       ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: pr13,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           padding: const EdgeInsets.symmetric(horizontal: 20),
          //         ),
          //         onPressed: () {},
          //         child: Text(
          //           'Ajukan Kembalian',
          //           style: Theme.of(context)
          //               .textTheme
          //               .bodyMedium!
          //               .copyWith(color: pr11),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
