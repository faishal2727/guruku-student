// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/profile/profile_bloc.dart';
import 'package:lottie/lottie.dart';
import '../widgets/detail_profile_content.dart';

class DetailProfilePage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_profile_page.dart';
  const DetailProfilePage({super.key});

  @override
  State<DetailProfilePage> createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProfileBloc>().add(OnProfileEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<ProfileBloc>().add(OnProfileEvent());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Detail Profile',
          style: AppTextStyle.heading5.setSemiBold(),
        ),
        backgroundColor: pr11,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
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
            final profile = state.dataProfile;
            return DetailProfileContent(profile!);
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
    );
  }
}
