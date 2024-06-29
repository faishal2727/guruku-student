import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/pages/auth/screens/sign_up_student_page.dart';
import 'package:guruku_student/presentation/pages/auth/screens/sign_up_teacher_page.dart';

class SignUpPage extends StatefulWidget {
  static const ROUTE_NAME = "/regsiter-page";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Registrasi Akun',
            style: AppTextStyle.heading5.setRegular(),
          ),
          backgroundColor: pr11,
          bottom: TabBar(
            indicatorColor: pr13,
            physics: const NeverScrollableScrollPhysics(),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Siswa',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  'Guru',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(child: SignUpStudentPage()),
            Center(child: SignUpTeacherPage()),
          ],
        ),
      ),
    );
  }
}
