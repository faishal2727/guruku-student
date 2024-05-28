import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';

class SettingPage extends StatelessWidget {
  static const ROUTE_NAME = "/setting-page";
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Pengaturan',
          style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
        ),
        backgroundColor: pr13,
        iconTheme: const IconThemeData(color: pr11),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text(
            'Dark Theme',
            style: AppTextStyle.body1.setMedium(),
          ),
          trailing: Switch.adaptive(value: false, onChanged: (value) {}),
        )
      ],
    );
  }
}
