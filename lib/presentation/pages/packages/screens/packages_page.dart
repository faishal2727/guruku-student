import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/packages/packages_bloc.dart';
import 'package:guruku_student/presentation/pages/packages/widgets/card_packages.dart';
import 'package:lottie/lottie.dart';

class PackagesPage extends StatefulWidget {
  static const ROUTE_NAME = "/packages-page";
  final int id;
  const PackagesPage({super.key, required this.id});

  @override
  State<PackagesPage> createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PackagesBloc>().add(GetListPackagesEvent(widget.id));
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<PackagesBloc>().add(GetListPackagesEvent(widget.id));
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    context.read<PackagesBloc>().add(GetListPackagesEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Paket"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<PackagesBloc, PackagesState>(
          builder: (context, state) {
            if (state.state == RequestStatePackages.loading) {
              return Center(
                child: Lottie.asset(
                  'assets/lotties/loading_state.json',
                  height: 180,
                  width: 180,
                ),
              );
            } else if (state.state == RequestStatePackages.loaded) {
              return ListView.builder(
                itemCount: state.packages!.length,
                itemBuilder: (context, index) {
                  final packages = state.packages![index];
                  return CardPackages(
                    packages: packages,
                  );
                },
              );
            } else if (state.state == RequestStatePackages.error) {
              return ErrorSection(
                isLoading: _isLoading,
                onPressed: _retry,
                message: state.message,
              );
            } else if (state.state == RequestStatePackages.empty) {
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
