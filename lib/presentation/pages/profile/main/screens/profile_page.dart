// ignore_for_file: constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/login/login_bloc.dart';
import 'package:guruku_student/presentation/pages/profile/bookmark/screens/bookmark_page.dart';
import 'package:guruku_student/presentation/pages/profile/detail_profile/screens/detail_profile_page.dart';
import 'package:guruku_student/presentation/pages/profile/faq/screens/faq_page.dart';
import 'package:guruku_student/presentation/pages/profile/main/widgets/avatar_content.dart';
import 'package:guruku_student/presentation/pages/profile/main/widgets/profile_list_item.dart';
import 'package:guruku_student/presentation/pages/profile/setting/screens/setting_page.dart';
import 'package:restart_app/restart_app.dart';

class ProfilePage extends StatefulWidget {
  static const ROUTE_NAME = '/profile_page';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: AppTextStyle.heading5
              .setSemiBold()
              .copyWith(color: AppColors.primary.pr11),
        ),
        backgroundColor: AppColors.primary.pr13,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary.pr13,
            child: const Column(
              children: [
                AvatarContent(),
                SizedBox(height: 16),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: Column(
              children: [
                ProfileListItem(
                  onTap: () {
                    Navigator.pushNamed(context, DetailProfilePage.ROUTE_NAME);
                  },
                  icon: Icons.person,
                  menuProfile: 'Detail Profile',
                ),
                const SizedBox(height: 8),
                ProfileListItem(
                  onTap: () {},
                  icon: Icons.shopping_bag,
                  menuProfile: 'Riwayat Pesanan',
                ),
                const SizedBox(height: 8),
                ProfileListItem(
                  onTap: () {
                    Navigator.pushNamed(context, BookmarkPage.ROUTE_NAME);
                  },
                  icon: Icons.favorite,
                  menuProfile: 'Bookmark',
                ),
                const SizedBox(height: 8),
                ProfileListItem(
                  onTap: () {
                    Navigator.pushNamed(context, FaqPage.ROUTE_NAME);
                  },
                  icon: Icons.question_answer,
                  menuProfile: 'FaQ',
                ),
                const SizedBox(height: 8),
                ProfileListItem(
                  onTap: () {},
                  icon: Icons.book,
                  menuProfile: 'Tentang Kami',
                ),
                const SizedBox(height: 8),
                ProfileListItem(
                  onTap: () {
                    Navigator.pushNamed(context, SettingPage.ROUTE_NAME);
                  },
                  icon: Icons.settings,
                  menuProfile: 'Pengaturan',
                ),
                const SizedBox(height: 8),
                ProfileListItem(
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.noHeader,
                      title: 'Keluar',
                      desc: 'Apakah Anda yakin ingin keluar ?',
                      btnCancelText: 'Batal',
                      btnOkText: 'Keluar',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        context.read<LoginBloc>().add(DoLogoutEvent());
                        Restart.restartApp();
                      },
                    ).show();
                  },
                  icon: Icons.logout,
                  menuProfile: 'Keluar',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
