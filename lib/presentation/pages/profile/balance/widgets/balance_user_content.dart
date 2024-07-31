import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/presentation/blocs/withdraw/withdraw_bloc.dart';
import 'package:guruku_student/presentation/pages/profile/balance/screens/withdraw_user_balance_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/balance/widgets/card_wd.dart';
import 'package:lottie/lottie.dart';

class BalanceUserContent extends StatefulWidget {
  final DetailProfileResponse profile;
  const BalanceUserContent({
    super.key,
    required this.profile,
  });

  @override
  State<BalanceUserContent> createState() => _BalanceUserContentState();
}

class _BalanceUserContentState extends State<BalanceUserContent> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    context.read<WithdrawBloc>().add(const OnListWdStudent());
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<WithdrawBloc>().add(const OnListWdStudent());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
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
                'Rp. ${widget.profile.balanceUser}',
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
                      context, WithdrawUserBalancePage.ROUTE_NAME);
                },
                child: Text(
                  'Penarikan Dana',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: pr11, fontSize: 14),
                ),
              ),
               const SizedBox(height: 8),
            ],
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<WithdrawBloc, WithdrawState>(
          builder: (context, state) {
            if (state.stateListWdStudent == ReqStateListWdStudent.loading) {
              return Center(
                child: Lottie.asset(
                  'assets/lotties/loading_state.json',
                  height: 180,
                  width: 180,
                ),
              );
            } else if (state.stateListWdStudent ==
                ReqStateListWdStudent.loaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.dataList!.length,
                itemBuilder: (context, index) {
                  final data = state.dataList![index];
                  return CardWithdraw(data: data);
                },
              );
            } else if (state.stateListWdStudent ==
                ReqStateListWdStudent.error) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else if (state.stateListWdStudent ==
                ReqStateListWdStudent.empty) {
              return const EmptySection();
            } else {
              return const Center(
                child: Text('Error Get History'),
              );
            }
          },
        ),
      ],
    );
  }
}
