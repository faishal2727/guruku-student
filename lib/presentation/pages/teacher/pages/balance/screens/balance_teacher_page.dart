// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';
import 'package:guruku_student/presentation/blocs/withdraw/withdraw_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/my_data_teacher/my_data_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/balance/screens/req_wd_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/balance/widgets/card_wd.dart';
import 'package:lottie/lottie.dart';


class BalanceTeacherPage extends StatefulWidget {
  static const ROUTE_NAME = "/balance-teacher-page";

  final MyDataTeacherResponse data;

  const BalanceTeacherPage({
    super.key,
    required this.data,
  });

  @override
  State<BalanceTeacherPage> createState() => _BalanceTeacherPageState();
}

class _BalanceTeacherPageState extends State<BalanceTeacherPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    context.read<MyDataTeacherBloc>().add(OnMyDataTeacherEvent(widget.data.id));
    context.read<WithdrawBloc>().add(OnListWdTeacher(idTeacher: widget.data.id));
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    _fetchData();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keuangan Guru',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Total Saldo',
                      style: AppTextStyle.body2.setMedium(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rp ${widget.data.balance}',
                      style: AppTextStyle.heading4.setMedium().copyWith(color: pr13),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pr13,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context, 
                          ReqWdTeacherPage.ROUTE_NAME,
                          arguments: widget.data,
                        );
                      },
                      child: Text(
                        'Penarikan Dana',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: pr11, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<WithdrawBloc, WithdrawState>(
                builder: (context, state) {
                  if (state.stateListWd == ReqStateListWd.loading) {
                    return Center(
                      child: Lottie.asset(
                        'assets/lotties/loading_state.json',
                        height: 180,
                        width: 180,
                      ),
                    );
                  } else if (state.stateListWd == ReqStateListWd.loaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.dataList!.length,
                      itemBuilder: (context, index) {
                        final data = state.dataList![index];
                        return CardWithdraw(data: data);
                      },
                    );
                  } else if (state.stateListWd == ReqStateListWd.error) {
                    return ErrorSection(
                      isLoading: _isLoading,
                      onPressed: _retry,
                      message: state.message,
                    );
                  } else if (state.stateListWd == ReqStateListWd.empty) {
                    return const EmptySection();
                  } else {
                    return const Center(
                      child: Text('Error Get History'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}