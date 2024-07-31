import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/get_present/get_present_bloc.dart';
import 'package:guruku_student/presentation/pages/history_order/widgets/card_order_present.dart';
import 'package:lottie/lottie.dart';

class PresentPage extends StatefulWidget {
  const PresentPage({super.key});

  @override
  State<PresentPage> createState() => _PresentPageState();
}

class _PresentPageState extends State<PresentPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<GetPresentBloc>().add(OnGetPresentEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<GetPresentBloc>().add(OnGetPresentEvent());
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    context.read<GetPresentBloc>().add(OnGetPresentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<GetPresentBloc, GetPresentState>(
          builder: (context, state) {
            if (state is GetPresentStateLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/lotties/loading_state.json',
                  height: 180,
                  width: 180,
                ),
              );
            } else if (state is GetPresentStateHasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  final order = state.result[index];
                  return CardOrderPresent(
                    dataHistoryOrder: order,
                  );
                },
              );
            } else if (state is GetPresentStateEmpty) {
              return const EmptySection();
            } else if (state is GetPresentStateError) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

