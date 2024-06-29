import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/presentation/pages/detail_teacher/screens/detail_teacher_page.dart';
import 'package:lottie/lottie.dart';

class CardTeacherHorizontal extends StatelessWidget {
  final List<Teacher> teachers;
  const CardTeacherHorizontal({super.key, required this.teachers});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: teachers.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          final teacher = teachers[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                DetailTeacherPage.ROUTE_NAME,
                arguments: teachers[index].id,
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 4, right: 4, top: 8),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color.fromARGB(43, 0, 0, 0),
                    blurRadius: 4,
                    offset: Offset(2, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 150,
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
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.amber,
                              ),
                              Text(
                                teacher.rate ?? '',
                                style: AppTextStyle.body4.setBold(),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teacher.name ?? "Not Name",
                          style: AppTextStyle.body3.setSemiBold(),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.book, size: 15, color: pr13),
                            Text(
                              teacher.typeTeaching ?? "",
                              style: AppTextStyle.body4
                                  .setSemiBold()
                                  .copyWith(color: pr13),
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Rp.${teacher.price}/Meet",
                          style: AppTextStyle.body3
                              .setSemiBold()
                              .copyWith(color: AppColors.primary.pr13),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
