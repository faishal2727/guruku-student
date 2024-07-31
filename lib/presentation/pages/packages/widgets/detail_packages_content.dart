import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/presentation/pages/packages/screens/order_packages_page.dart';

class DetailPackagesContent extends StatefulWidget {
  final Packages data;
  const DetailPackagesContent({
    super.key,
    required this.data,
  });

  @override
  State<DetailPackagesContent> createState() => _DetailPackagesContentState();
}

class _DetailPackagesContentState extends State<DetailPackagesContent> {
  String? selectedTime;

  void _navigateToOrderPage() {
    if (selectedTime != null) {
      Navigator.pushNamed(
        context,
        OrderPackagesPage.ROUTE_NAME,
        arguments: {
          'id': widget.data.id, // Assuming `Packages` has an `id` field
          'selectedTime': selectedTime!,
        },
      );
    } else {
      // Show a message to the user to select a time
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a time"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.data.name!, style: AppTextStyle.body1.setSemiBold()),
          Text(widget.data.desc!, style: AppTextStyle.body3.setRegular()),
          Text("Durasi : ${widget.data.duration} Jam",
              style: AppTextStyle.body3.setRegular()),
              Text("Jumlah Pertemuan : ${widget.data.sessions} Kali",
              style: AppTextStyle.body3.setRegular()),
          Text("Harga : Rp.${widget.data.price} ",
              style: AppTextStyle.body3.setRegular()),
          Row(
            children: [
              Text("Hari Pertemuan : ", style: AppTextStyle.body3.setRegular()),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: widget.data.day != null && widget.data.day!.isNotEmpty
                    ? Wrap(
                        direction: Axis.horizontal,
                        spacing: 8.0,
                        children: widget.data.day!.map((type) {
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
          Text("Pilih Jam Pertemuan : ",
              style: AppTextStyle.body3.setRegular()),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: widget.data.time != null && widget.data.time!.isNotEmpty
                ? Column(
                    children: widget.data.time!.map((time) {
                      return RadioListTile<String>(
                        title: Text(
                          time,
                          style: AppTextStyle.body3.setRegular(),
                        ),
                        value: time,
                        groupValue: selectedTime,
                        onChanged: (value) {
                          setState(() {
                            selectedTime = value;
                          });
                        },
                      );
                    }).toList(),
                  )
                : Text(
                    "No teaching times available",
                    style: AppTextStyle.body3.setSemiBold().copyWith(
                          color: AppColors.primary.pr13,
                        ),
                  ),
          ),
          ElevatedButton(
            onPressed: _navigateToOrderPage,
            child: const Text("Pilih Paket"),
          ),
        ],
      ),
    );
  }
}

