
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/packages/packages_bloc.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/packages/widgets/card_my_packages.dart';
import 'package:lottie/lottie.dart';

class MyPackagesPage extends StatefulWidget {
  static const ROUTE_NAME = "/my-packages-page";
  const MyPackagesPage({super.key});

  @override
  State<MyPackagesPage> createState() => _MyPackagesPageState();
}

class _MyPackagesPageState extends State<MyPackagesPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PackagesBloc>().add(GetListMyPackagesEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<PackagesBloc>().add(GetListMyPackagesEvent());
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    context.read<PackagesBloc>().add(GetListMyPackagesEvent());
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
                  return CardMyPackages(
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
