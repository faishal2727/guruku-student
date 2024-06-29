// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/notif/notif_bloc.dart';
import 'package:guruku_student/presentation/pages/notification/widgets/card_notification.dart';
import 'package:lottie/lottie.dart';

class NotificationPage extends StatefulWidget {
  static const ROUTE_NAME = "/notif-page";
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NotifBloc>().add(OnGetNotifEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<NotifBloc>().add(OnGetNotifEvent());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pr11,
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
      ),
      body: BlocBuilder<NotifBloc, NotifState>(
        builder: (context, state) {
          if (state.state == ReqStateNotif.loading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading_state.json',
                height: 180,
                width: 180,
              ),
            );
          } else if (state.state == ReqStateNotif.loaded) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.listData!.length,
              itemBuilder: (context, index) {
                final order = state.listData![index];
                return CardNotification(data: order);
              },
            );
          } else if (state.state == ReqStateNotif.error) {
            return ErrorSection(
              isLoading: _isLoading,
              onPressed: _retry,
              message: state.message,
            );
          } else if (state.state == ReqStateNotif.empty) {
            return const EmptySection();
          } else {
            return const Center(
              child: Text('Error Get History'),
            );
          }
        },
      ),
    );
  }
}
