// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/review/review_bloc.dart';
import 'package:guruku_student/presentation/pages/review_list/widgets/card_review.dart';

class ListReviewPage extends StatefulWidget {
  static const ROUTE_NAME = "/list-review";
  final int id;
  const ListReviewPage({
    super.key,
    required this.id,
  });

  @override
  State<ListReviewPage> createState() => _ListReviewPageState();
}

class _ListReviewPageState extends State<ListReviewPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ReviewBloc>().add(GetListReviewEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penilaian & Ulasan',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
      ),
      body: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          if (state.state == RequestStateReview.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == RequestStateReview.loaded) {
            return ListView.builder(
              itemCount: state.review!.length,
              itemBuilder: (context, index) {
                final data = state.review![index];
                return CardReview(review: data);
              },
            );
          } else if (state.state == RequestStateReview.error) {
            return const Text('Error');
          } else if (state.state == RequestStateReview.empty) {
            return const EmptySection();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
