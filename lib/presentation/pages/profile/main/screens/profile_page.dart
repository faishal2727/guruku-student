// ignore_for_file: constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/login/login_bloc.dart';
import 'package:guruku_student/presentation/pages/profile/detail_profile/screens/detail_profile_page.dart';
import 'package:guruku_student/presentation/pages/profile/main/widgets/avatar_content.dart';
import 'package:guruku_student/presentation/pages/profile/main/widgets/my_order_widget.dart';
import 'package:guruku_student/presentation/pages/profile/main/widgets/profile_list_item.dart';
import 'package:guruku_student/presentation/pages/profile/wishlist/screens/wishlist_page.dart';
import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  static const ROUTE_NAME = '/profile_page';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _composeMail() {
// #docregion encode-query-parameters
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'smith@example.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Example Subject & Symbols are allowed!',
      }),
    );

    launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary.pr13,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.primary.pr14,
              child: const AvatarContent(),
            ),
            const MyOrderWidget(),
            Divider(thickness: 12, color: pr16),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                children: [
                  ProfileListItem(
                    onTap: () {
                      Navigator.pushNamed(
                          context, DetailProfilePage.ROUTE_NAME);
                    },
                    icon: Icons.person,
                    menuProfile: 'Profile',
                  ),
                  const SizedBox(height: 8),
                  ProfileListItem(
                    onTap: () {
                      Navigator.pushNamed(context, WishlistPage.ROUTE_NAME);
                    },
                    icon: Icons.favorite,
                    menuProfile: 'Wishlist',
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _composeMail,
        tooltip: 'Pusat Bantuan',
        child: const Icon(Icons.mail),
      ),
    );
  }
}