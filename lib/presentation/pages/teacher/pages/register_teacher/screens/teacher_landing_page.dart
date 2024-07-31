// ignore_for_file: use_build_context_synchronously, constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/login/login_bloc.dart';
import 'package:guruku_student/presentation/blocs/profile/profile_bloc.dart';
import 'package:guruku_student/presentation/pages/profile/detail_profile/screens/detail_profile_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/widgets/welcome_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:restart_app/restart_app.dart';

class TeacherLandingPage extends StatefulWidget {
  static const ROUTE_NAME = "/register-teacher";
  const TeacherLandingPage({super.key});

  @override
  State<TeacherLandingPage> createState() => _TeacherLandingPageState();
}

class _TeacherLandingPageState extends State<TeacherLandingPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
    });
    context.read<ProfileBloc>().add(OnProfileEvent());
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _retry() async {
    setState(() {
      _isLoading = true;
    });
    context.read<ProfileBloc>().add(OnProfileEvent());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Guruku '),
        backgroundColor: pr11,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, DetailProfilePage.ROUTE_NAME);
              },
              icon: const Icon(Icons.person)),
          IconButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.noHeader,
                title: 'Keluar',
                desc: 'Apakah Anda yakin ingin keluar?',
                btnCancelText: 'Batal',
                btnOkText: 'Keluar',
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  context.read<LoginBloc>().add(DoLogoutEvent());
                  Restart.restartApp();
                },
              ).show();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadProfile,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state.stateProfile == ReqStateProfile.loading) {
                return Center(
                  child: Lottie.asset(
                    'assets/lotties/loading.json',
                    height: 200,
                    width: 200,
                  ),
                );
              } else if (state.stateProfile == ReqStateProfile.loaded) {
                final data = state.dataProfile;
                return WelcomeWidget(data: data!);
              } else if (state.stateProfile == ReqStateProfile.empty) {
                return const EmptySection();
              } else if (state.stateProfile == ReqStateProfile.error) {
                return ErrorSection(
                  isLoading: _isLoading,
                  onPressed: _retry,
                  message: state.message,
                );
              } else {
                return const Text(
                  'unexpected state',
                  key: Key('unexpected_state_message'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
