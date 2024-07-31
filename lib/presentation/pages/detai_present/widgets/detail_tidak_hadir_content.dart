import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailTidakHadirContent extends StatefulWidget {
  final DetailHistoryOrder dataHistoryOrder;
  const DetailTidakHadirContent({
    Key? key,
    required this.dataHistoryOrder,
  }) : super(key: key);

  @override
  State<DetailTidakHadirContent> createState() =>
      _DetailTidakHadirContentState();
}

class _DetailTidakHadirContentState extends State<DetailTidakHadirContent> {
  final TextEditingController controller = TextEditingController();
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _composeMail() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'guruku.corp@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Pengajuan Dana Kembali',
      }),
    );

    launchUrl(emailLaunchUri);
  }

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
                          style: AppTextStyle.body3.setSemiBold()),
                      Text(widget.dataHistoryOrder.mapel,
                          style: AppTextStyle.body4.setRegular()),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                  'Id Transaksi',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  "${widget.dataHistoryOrder.code}",
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
                  'Status Pembayaran',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  "${widget.dataHistoryOrder.paymentStatus}",
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
                  'Metode Pembayaran',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  widget.dataHistoryOrder.bank!.toUpperCase(),
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
                  'Tanggal Pertemuan',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  formatDate(
                      widget.dataHistoryOrder.meetingTime!.toIso8601String()),
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
                  'Waktu Transaksi',
                  style: AppTextStyle.body3.setRegular(),
                ),
                Text(
                  formatDate(
                      widget.dataHistoryOrder.createdAt.toIso8601String()),
                  style: AppTextStyle.body3.setRegular(),
                )
              ],
            ),
          ),
          Divider(thickness: 3, color: pr16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Guru dianggap tidak hadir, saldo anda akan dikembalikan ke saldo kamu, baca syarat dan ketentuan untuk penarikan saldo',
              style: AppTextStyle.body4.setRegular(),
            ),
          ),
        ],
      ),
    );
  }
}
