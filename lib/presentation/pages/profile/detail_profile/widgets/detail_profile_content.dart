// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/presentation/pages/profile/detail_profile/widgets/data_user_widget.dart';
import 'package:guruku_student/presentation/pages/profile/update_profile/screens/update_profile_page.dart';
import 'package:intl/intl.dart';

class DetailProfileContent extends StatelessWidget {
  final DetailProfileResponse profile;

  const DetailProfileContent(this.profile);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        DataUserWidget(
          title: 'Username',
          desc: profile.username ?? 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Nama',
          desc: profile.name ?? 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Email',
          desc: profile.email ?? 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Nomor Hp',
          desc: profile.phone ?? 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Pendidikan',
          desc: profile.education ?? 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Tanggal Lahir',
          desc: profile.bod != null
              ? _formatDate(profile.bod!)
              : 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Alamat',
          desc: profile.address ?? 'Data belum ada',
        ),
        const SizedBox(height: 16),
        Center(
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UpdateProfilePage(profile: profile);
              }));
            },
            child: Text(
              "Edit Profile",
              style: AppTextStyle.body2
                  .copyWith(fontWeight: FontWeight.bold, color: pr13),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('dd MMMM yyyy').format(dateTime);
    } catch (e) {
      return 'Format tanggal tidak valid';
    }
  }
}
