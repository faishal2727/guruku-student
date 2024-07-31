
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/get_present/get_present_bloc.dart';
import 'package:guruku_student/presentation/pages/history_order/widgets/card_tidak_hadir.dart';
import 'package:lottie/lottie.dart';

class TidakHadirPage extends StatefulWidget {
  const TidakHadirPage({super.key});

  @override
  State<TidakHadirPage> createState() => _TidakHadirPageState();
}

class _TidakHadirPageState extends State<TidakHadirPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<GetPresentBloc>().add(OnGetPresentTidakEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<GetPresentBloc>().add(OnGetPresentTidakEvent());
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    context.read<GetPresentBloc>().add(OnGetPresentTidakEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<GetPresentBloc, GetPresentState>(
          builder: (context, state) {
            if (state is GetPresentTidakLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/lotties/loading_state.json',
                  height: 180,
                  width: 180,
                ),
              );
            } else if (state is GetPresentTidakHasData) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  final order = state.result[index];
                  return CardTidakHadir(
                    dataHistoryOrder: order,
                  );
                },
              );
            } else if (state is GetPresentTidakEmpty) {
              return const EmptySection();
            } else if (state is GetPresentTidakError) {
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
