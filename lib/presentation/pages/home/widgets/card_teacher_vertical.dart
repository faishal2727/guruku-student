// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/presentation/pages/detail_teacher/screens/detail_teacher_page.dart';
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
        width: MediaQuery.of(context).size.width * 0.8,
        height: 150,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: const [
            BoxShadow(
              color: Color.fromARGB(43, 0, 0, 0),
              blurRadius: 10,
              offset: Offset(2, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    height: 140,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: teacher.picture != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: teacher.picture!,
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
                ],
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 3,
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
                      Icon(Icons.book, size: 15, color: AppColors.primary.pr10),
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
                    '${teacher.distance!.toStringAsFixed(2)} Km dari Lokasi anda',
                    style:
                        AppTextStyle.body3.setSemiBold().copyWith(color: pr13),
                  ) // Update jarak dengan data jarak yang dihitung
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Padding(
                        //         padding: const EdgeInsets.only(left: 16),
                        //         child: teacher.typeTeaching != null &&
                        //                 teacher.typeTeaching!.isNotEmpty
                        //             ? Wrap(
                        //                 direction: Axis.horizontal,
                        //                 spacing: 8.0, // Atur jarak antar item
                        //                 children: teacher.typeTeaching!
                        //                     .map((type) {
                        //                   return Text(
                        //                     type,
                        //                     style: AppTextStyle.body3
                        //                         .setSemiBold()
                        //                         .copyWith(
                        //                           color: AppColors.primary.pr13,
                        //                         ),
                        //                   );
                        //                 }).toList(),
                        //               )
                        //             : Text(
                        //                 "No teaching types available",
                        //                 style: AppTextStyle.body3
                        //                     .setSemiBold()
                        //                     .copyWith(
                        //                       color: AppColors.primary.pr13,
                        //                     ),
                        //               ),
                        //       ),



 // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   child: Container(
                    //     padding: const EdgeInsets.all(4),
                    //     width: 50,
                    //     height: 25,
                    //     decoration: BoxDecoration(
                    //       color: AppColors.primary.pr01,
                    //       borderRadius: const BorderRadius.only(
                    //         topLeft: Radius.circular(12),
                    //         bottomRight: Radius.circular(13),
                    //       ),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Icon(
                    //           Icons.star,
                    //           color: AppColors.warning.wn05,
                    //           size: 18,
                    //         ),
                    //         Text(
                    //           '4.5',
                    //           style: AppTextStyle.body4.setSemiBold(),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )