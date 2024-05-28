// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
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
          style: AppTextStyle.heading5.setSemiBold().copyWith(color: pr11),
        ),
        backgroundColor: pr13,
        iconTheme: const IconThemeData(color: pr11),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading.json',
                height: 200,
                width: 200,
              ),
            );
          } else if (state is ProfileHasData) {
            final profile = state.result;
            return DetailProfileContent(profile);
          } else if (state is UpdateProfileSuccess) {
            Navigator.pop(context);
            return const SizedBox();
          } else if (state is ProfileEmpty) {
            return const EmptySection();
          } else if (state is ProfileError) {
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
