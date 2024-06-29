import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/shared_widgets/error_section.dart';
import 'package:guruku_student/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:guruku_student/presentation/pages/profile/wishlist/widgets/card_wishlist.dart';

class WishlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/wishlist-page';
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WishlistBloc>().add(GetAllWishlistEvent());
    });
  }

  void _retry() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    context.read<WishlistBloc>().add(GetAllWishlistEvent());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Guru'),
        backgroundColor: pr11,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WishlistLoaded) {
              final result = state.data;
              return CardWishlist(teachers: result);
            } else if (state is WishlistError) {
              return Center(
                child: ErrorSection(
                  isLoading: _isLoading,
                  onPressed: _retry,
                  message: state.message,
                ),
              );
            } else if (state is WishlistEmpty) {
              return const Center(child: EmptySection());
            } else {
              return const Center(
                child: Text('Error Get Teacher'),
              );
            }
          },
        ),
      ),
    );
  }
}
