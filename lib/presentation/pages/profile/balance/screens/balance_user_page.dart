// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/profile/profile_bloc.dart';
import 'package:guruku_student/presentation/pages/profile/balance/widgets/balance_user_content.dart';
import 'package:lottie/lottie.dart';

class BalanceUserPage extends StatefulWidget {
  static const ROUTE_NAME = "/balance-user-page";

  const BalanceUserPage({super.key});

  @override
  State<BalanceUserPage> createState() => _BalanceUserPageState();
}

class _BalanceUserPageState extends State<BalanceUserPage> {
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
          'Saldo Kamu',
          style: AppTextStyle.heading5.setSemiBold(),
        ),
        backgroundColor: pr11,
      ),
      body: SingleChildScrollView(
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
              final profile = state.dataProfile;
              return BalanceUserContent(
                profile: profile!,
              );
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
    );
  }
}
