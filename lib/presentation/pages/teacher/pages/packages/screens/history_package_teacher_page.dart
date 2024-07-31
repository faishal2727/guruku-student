import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/history_order_packages/history_order_packages_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/widgets/card_success_packges_teacher.dart';
import 'package:lottie/lottie.dart';

class HistoryPackageTeacherPage extends StatefulWidget {
  static const ROUTE_NAME = "/history-order-packages-teacher";
  const HistoryPackageTeacherPage({super.key});

  @override
  State<HistoryPackageTeacherPage> createState() =>
      _HistoryPackageTeacherPageState();
}

class _HistoryPackageTeacherPageState extends State<HistoryPackageTeacherPage> {
  bool _isLoading = false;
  String _selectedFilter = 'all'; // default filter

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<HistoryOrderPackagesBloc>()
          .add(OnOrderPackagesTeacherEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<HistoryOrderPackagesBloc>().add(OnOrderPackagesTeacherEvent());
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    context.read<HistoryOrderPackagesBloc>().add(OnOrderPackagesTeacherEvent());
  }

  void _onMenuSelected(String value) {
    setState(() {
      _selectedFilter = value;
    });
    context
        .read<HistoryOrderPackagesBloc>()
        .add(OnOrderPackagesTeacherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan Paketan'),
        backgroundColor: pr11,
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            itemBuilder: (BuildContext context) {
              return {'all', 'success', 'cancel'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<HistoryOrderPackagesBloc, HistoryOrderPackagesState>(
          builder: (context, state) {
            if (state is OrderPackagesTeacherLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/lotties/loading_state.json',
                  height: 180,
                  width: 180,
                ),
              );
            } else if (state is OrderPackagesTeacherHasData) {
              var filteredOrders = state.result.where((order) {
                if (_selectedFilter == 'all') return true;
                return order.paymentStatus == _selectedFilter;
              }).toList();

              return ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  if (order.paymentStatus == 'success') {
                    return CardSuccessPackagesTeacher(dataHistoryOrder: order);
                  } else {
                    return const SizedBox
                        .shrink(); // Handle 'cancel' or other states if needed
                  }
                },
              );
            } else if (state is OrderPackagesTeacherError) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else if (state is OrderPackagesTeacherEmpty) {
              return const EmptySection();
            } else {
              return const Center(
                child: Text('Error Get History'),
              );
            }
          },
        ),
      ),
    );
  }
}
