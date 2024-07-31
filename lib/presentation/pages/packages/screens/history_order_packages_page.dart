// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/history_order_packages/history_order_packages_bloc.dart';
import 'package:guruku_student/presentation/pages/packages/widgets/card_pending_packages.dart';
import 'package:guruku_student/presentation/pages/packages/widgets/card_success_packages.dart';
import 'package:lottie/lottie.dart';

class HistoryOrderPackagesPage extends StatefulWidget {
  static const ROUTE_NAME = "/history-order-packages";
  const HistoryOrderPackagesPage({super.key});

  @override
  State<HistoryOrderPackagesPage> createState() =>
      _HistoryOrderPackagesPageState();
}
class _HistoryOrderPackagesPageState extends State<HistoryOrderPackagesPage> {
  bool _isLoading = false;
  String _selectedFilter = 'all'; // default filter

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HistoryOrderPackagesBloc>().add(OnOrderPackagesEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<HistoryOrderPackagesBloc>().add(OnOrderPackagesEvent());
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    context.read<HistoryOrderPackagesBloc>().add(OnOrderPackagesEvent());
  }

  void _onMenuSelected(String value) {
    setState(() {
      _selectedFilter = value;
    });
    context.read<HistoryOrderPackagesBloc>().add(OnOrderPackagesEvent()); // Optionally refresh the data
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
              return {'all', 'pending', 'success', 'cancel'}.map((String choice) {
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
            if (state is OrderPackagesLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/lotties/loading_state.json',
                  height: 180,
                  width: 180,
                ),
              );
            } else if (state is OrderPackagesHasData) {
              var filteredOrders = state.result.where((order) {
                if (_selectedFilter == 'all') return true;
                return order.paymentStatus == _selectedFilter;
              }).toList();

              return ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  if (order.paymentStatus == 'pending') {
                    return CardPendingPackages(dataHistoryOrder: order);
                  } else if (order.paymentStatus == 'success') {
                    return CardSuccessPackages(dataHistoryOrder: order);
                  } else {
                    return SizedBox.shrink(); // Handle 'cancel' or other states if needed
                  }
                },
              );
            } else if (state is OrderPackagesError) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else if (state is OrderPackagesEmpty) {
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
