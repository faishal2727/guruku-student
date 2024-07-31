// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/presentation/pages/profile/detail_profile/widgets/data_user_widget.dart';
import 'package:guruku_student/presentation/pages/profile/update_avatar/update_avatar_page.dart';
import 'package:guruku_student/presentation/pages/profile/update_profile/screens/update_profile_page.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class DetailProfileContent extends StatefulWidget {
  final DetailProfileResponse profile;

  DetailProfileContent(this.profile);

  @override
  State<DetailProfileContent> createState() => _DetailProfileContentState();
}

class _DetailProfileContentState extends State<DetailProfileContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, UpdateAvatarPage.ROUTE_NAME);
          },
          child: Center(
            child: Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: widget.profile.images != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: widget.profile.images!,
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => Center(
                              child: Lottie.asset(
                                  'assets/lotties/loading_state.json',
                                  height: 180,
                                  width: 180),
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
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: ShapeDecoration(
                        shape: const OvalBorder(),
                        color: AppColors.primary.pr14),
                    child: Icon(
                      Icons.edit,
                      color: AppColors.primary.pr10,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        DataUserWidget(
          title: 'Username',
          desc: widget.profile.username ?? 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Nama',
          desc: widget.profile.name ?? 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Email',
          desc: widget.profile.email ?? 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Nomor Hp',
          desc: widget.profile.phone ?? 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Pendidikan',
          desc: widget.profile.education ?? 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Tanggal Lahir',
          desc: widget.profile.bod != null
              ? _formatDate(widget.profile.bod!)
              : 'Data belum ada',
        ),
        const SizedBox(height: 2),
        DataUserWidget(
          title: 'Alamat',
          desc: widget.profile.address ?? 'Data belum ada',
        ),
        const SizedBox(height: 16),
        Center(
          child: InkWell(
            onTap: () async {
              Navigator.pushNamed(
                context,
                UpdateProfilePage.ROUTE_NAME,
                arguments: widget.profile,
              );
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
