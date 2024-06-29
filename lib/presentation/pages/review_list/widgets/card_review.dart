import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/common/utils/date_utils.dart';
import 'package:guruku_student/domain/entity/review/review.dart';

class CardReview extends StatelessWidget {
  final Review review;
  const CardReview({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: pr16),
          bottom: BorderSide(color: pr16),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: const ShapeDecoration(
              color: pr15,
              shape: OvalBorder(),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.student.username,
                style: AppTextStyle.body3.setSemiBold(),
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: double.parse(review.rate) / 1,
                    itemCount: 5,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: kMikadoYellow,
                    ),
                    itemSize: 18,
                  ),
                  Text('${review.rate}')
                ],
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                    color: pr14, borderRadius: BorderRadius.circular(4)),
                child: Text(review.detail!),
              ),
              const SizedBox(height: 4),
              Text(
                review.desc,
                style: AppTextStyle.body4.setRegular(),
              ),
              const SizedBox(height: 4),
              Text(
                formatDate(review.createdAt.toIso8601String()),
                style: AppTextStyle.body4
                    .setRegular()
                    .copyWith(color: Colors.grey.shade500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
