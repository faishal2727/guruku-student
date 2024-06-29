// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/presentation/blocs/review/review_bloc.dart';
import 'package:guruku_student/presentation/pages/auth/widgets/my_text_form_field.dart';
import 'package:guruku_student/presentation/pages/review_post/widgets/button_post_review.dart';

class AddReviewPage extends StatefulWidget {
  static const ROUTE_NAME = "/add-review";
  final DetailHistoryOrder dataHistoryOrder;
  const AddReviewPage({
    super.key,
    required this.dataHistoryOrder,
  });

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final GlobalKey<FormState> _postFormKey = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();
  double rating = 0.0;
  String? selectedChip;

  final Map<double, List<String>> ratingChipChoices = {
    1.0: ["Very Poor", "Unacceptable"],
    2.0: ["Poor", "Needs Improvement"],
    3.0: ["Average", "Fair"],
    4.0: ["Good", "Very Good"],
    5.0: ["Excellent", "Outstanding"],
  };

  void _postReview() {
    context.read<ReviewBloc>().add(
          PostReviewEvent(
              idTeacher: widget.dataHistoryOrder.idTeacher!,
              idOrder: widget.dataHistoryOrder.id,
              rate: rating.toString(),
              desc: descController.text,
              detail: selectedChip.toString()),
        );
  }

  void _submit() {
    if (_postFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _postReview();
    }
  }

  List<String> getChipsForRating(double rating) {
    // Get the closest integer rating key
    double closestRating = ratingChipChoices.keys
        .reduce((a, b) => (a - rating).abs() < (b - rating).abs() ? a : b);
    return ratingChipChoices[closestRating] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beri Ulasan',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
      ),
      body: BlocListener<ReviewBloc, ReviewState>(
        listener: (context, state) {
          if (state.state == RequestStateReview.error) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text(
                    'Gagal',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.red[400],
                ),
              );
          } else if (state.state == RequestStateReview.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Berhasil!',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        child: Container(
          color: Colors.white,
          child: Form(
            key: _postFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'order id ${widget.dataHistoryOrder.id}',
                  style: AppTextStyle.body2.setMedium(),
                ),
                Text(
                  'teacher id ${widget.dataHistoryOrder.idTeacher}',
                  style: AppTextStyle.body2.setMedium(),
                ),
                Divider(thickness: 8, color: Colors.grey.shade100),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Kualitas Guru',
                        style: AppTextStyle.body2.setMedium(),
                      ),
                      const SizedBox(width: 20),
                      RatingBar.builder(
                        initialRating: rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (newRating) {
                          setState(() {
                            rating = newRating;
                            selectedChip = null;
                          });
                        },
                        itemSize: 35.0,
                      ),
                    ],
                  ),
                ),
                if (rating > 0)
                  Divider(thickness: 8, color: Colors.grey.shade100),
                if (rating > 0)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Wrap(
                      spacing: 8.0,
                      children: getChipsForRating(rating).map((choice) {
                        return ChoiceChip(
                          backgroundColor: pr11,
                          selectedColor: pr14,
                          label: Text(
                            choice,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 14),
                          ),
                          selected: selectedChip == choice,
                          onSelected: (selected) {
                            setState(() {
                              selectedChip = selected ? choice : null;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                Divider(thickness: 8, color: Colors.grey.shade100),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextFormField(
                        labelText: "Deskripsi",
                        controller: descController,
                        hintText: 'Masukan Deskripsi . . .',
                        lable: 'Deskripsi',
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 8, color: Colors.grey.shade100),
                ButtonPostReview(onPressed: _submit, title: 'Kirim')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
