// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/withdraw/withdraw_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/balance/widgets/wd_detail_content.dart';
import 'package:lottie/lottie.dart';

class WdDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-wd-page';
  final int id;

  const WdDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<WdDetailPage> createState() => _WdDetailPageState();
}

class _WdDetailPageState extends State<WdDetailPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print('Received ID: ${widget.id}'); // Debug print
    context.read<WithdrawBloc>().add(OnDetailWd(id: widget.id));
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<WithdrawBloc>().add(OnDetailWd(id: widget.id));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail WD ${widget.id}',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
      ),
      body: BlocBuilder<WithdrawBloc, WithdrawState>(
        builder: (context, state) {
          if (state.stateWdDetail == ReqStateWdDetail.loading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading_state.json',
                height: 180,
                width: 180,
              ),
            );
          } else if (state.stateWdDetail == ReqStateWdDetail.loaded) {
            final data = state.dataDetail;
            return WdDetailContent(data: data!);
          } else if (state.stateWdDetail == ReqStateWdDetail.empty) {
            return const EmptySection();
          } else if (state.stateWdDetail == ReqStateWdDetail.error) {
            return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}


