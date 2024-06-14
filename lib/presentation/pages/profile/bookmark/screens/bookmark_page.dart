// ignore_for_file: annotate_overrides, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/utils.dart';
import 'package:guruku_student/presentation/blocs/bookmark/bookmark_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/home/widgets/card_teacher_vertical.dart';
import 'package:guruku_student/presentation/pages/home/widgets/shimmer_card_vertical.dart';

class BookmarkPage extends StatefulWidget {
  static const ROUTE_NAME = '/bookmark-page';
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<BookmarkTeacherBloc>().add(OnGetBookmarkTeacher()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<BookmarkTeacherBloc>().add(OnGetBookmarkTeacher());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
        backgroundColor: pr11,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<BookmarkTeacherBloc, BookmarkTeacherState>(
          builder: (context, state) {
            if (state is BookmarkTeacherLoading) {
              return const Center(
                child: CardShimmerVertical(),
              );
            } else if (state is BookmarkTeacherHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final teacher = state.result[index];
                  return CardTeacherVertical(teacher: teacher);
                },
                itemCount: state.result.length,
              );
            } else if (state is BookmarkTeacherEmpty) {
              return const EmptySection();
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('error'),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
