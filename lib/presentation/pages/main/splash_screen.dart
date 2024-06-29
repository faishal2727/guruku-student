// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/presentation/blocs/login/login_bloc.dart';
import 'package:guruku_student/presentation/blocs/main/main_bloc.dart';
import 'package:guruku_student/presentation/pages/auth/screens/login_page.dart';
import 'package:guruku_student/presentation/pages/main/student_landing_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/screens/teacher_landing_page.dart';

class SplashScreen extends StatefulWidget {
  static const ROUTE_NAME = "/splash";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLogin = false;
  String _role = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<LoginBloc>().add(DoAuthCheckEventk());
      context.read<MainBloc>().add(DoIsLoginEvent());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<MainBloc, MainState>(
            listener: (context, state) {
              setState(() {
                _isLogin = state.isLogin;
                _role = state.role;
              });
              _navigateToHome();
            },
          ),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              context.read<MainBloc>().add(DoIsLoginEvent());
            },
          ),
        ],
        child: Center(
          child: Image.asset(
            'assets/images/icon-app.png',
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }

  void _navigateToHome() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_isLogin) {
        if (_role == 'student') {
          Navigator.pushReplacementNamed(
              context, StudentLandingPage.ROUTE_NAME);
        } else if (_role == 'teacher') {
          Navigator.pushReplacementNamed(
              context, TeacherLandingPage.ROUTE_NAME);
        }
      } else {
        Navigator.pushReplacementNamed(context, LoginPage.ROUTE_NAME);
      }
    });
  }
}
