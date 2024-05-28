// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/presentation/pages/detail/screens/detail_teacher_page.dart';
import 'package:lottie/lottie.dart';

class CardTeacherVertical extends StatelessWidget {
  final Teacher teacher;
  const CardTeacherVertical({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailTeacherPage.ROUTE_NAME,
          arguments: teacher.id,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 6),
        width: MediaQuery.of(context).size.width,
        height: 140,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 10,
              offset: Offset(4, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: teacher.avatar != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: teacher.avatar!,
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: double.infinity,
                                placeholder: (context, url) => Center(
                                  child: Lottie.asset(
                                      'assets/lotties/loading_state.json',
                                      height: 180,
                                      width: 180),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(Icons.error, color: Colors.red),
                                ),
                              ),
                            )
                          : const Center(
                              child: Icon(Icons.warning, color: Colors.red),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        width: 50,
                        height: 25,
                        decoration: BoxDecoration(
                          color: AppColors.primary.pr01,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(13),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.warning.wn05,
                              size: 18,
                            ),
                            Text(
                              '4.5',
                              style: AppTextStyle.body4.setSemiBold(),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      teacher.name ?? "",
                      style: AppTextStyle.body2.setSemiBold(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.book,
                            size: 15, color: AppColors.primary.pr10),
                        Text(
                          maxLines: 1,
                          teacher.typeTeaching ?? "",
                          style: AppTextStyle.body4.setRegular(),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 15, color: AppColors.primary.pr10),
                        Expanded(
                          child: Text(
                            maxLines: 1,
                            teacher.addess ?? "",
                            style: AppTextStyle.body4.setRegular(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Rp. ${teacher.price}/Meet",
                      style: AppTextStyle.body3
                          .setSemiBold()
                          .copyWith(color: AppColors.primary.pr13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
