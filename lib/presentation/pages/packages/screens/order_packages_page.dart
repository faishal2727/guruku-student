import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/packages/packages_bloc.dart';
import 'package:guruku_student/presentation/pages/packages/widgets/detail_order_packages_content.dart';
import 'package:lottie/lottie.dart';

class OrderPackagesPage extends StatefulWidget {
  static const ROUTE_NAME = "/order-packages";
  final int id;
  final String selectedTime;

  const OrderPackagesPage({
    super.key,
    required this.id,
    required this.selectedTime,
  });

  @override
  State<OrderPackagesPage> createState() => _OrderPackagesPageState();
}
class _OrderPackagesPageState extends State<OrderPackagesPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<PackagesBloc>().add(OnDetailPackagesEvent(widget.id));
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<PackagesBloc>().add(OnDetailPackagesEvent(widget.id));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rincian',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
      ),
      body: BlocBuilder<PackagesBloc, PackagesState>(
        builder: (context, state) {
          if (state.stateDetail == RequestStatePackagesDetail.loading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading_state.json',
                height: 180,
                width: 180,
              ),
            );
          } else if (state.stateDetail == RequestStatePackagesDetail.loaded) {
            final data = state.detail;
            return DetailOrderPackagesContent(data: data!, selectedTime: widget.selectedTime);
          } else if (state.stateDetail == RequestStatePackagesDetail.empty) {
            return const EmptySection();
          } else if (state.stateDetail == RequestStatePackagesDetail.error) {
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
