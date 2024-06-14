// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';
import 'package:guruku_student/presentation/blocs/bookmark/bookmark_teacher_bloc.dart';
import 'package:guruku_student/presentation/pages/detail/widgets/maps_widgets_detail.dart';
import 'package:readmore/readmore.dart';

class DetailContent extends StatefulWidget {
  final TeacherDetail teacher;
  bool isAddedBookmark;

  DetailContent(this.teacher, this.isAddedBookmark);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  Image.network(
                    widget.teacher.picture ?? '',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: const Color.fromARGB(255, 111, 111, 111)
                        .withOpacity(0.3),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: const Color.fromARGB(13, 51, 51, 51),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      widget.teacher.picture ?? '',
                      width: 280,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.grey.shade100,
                        margin: const EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 5,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.primary.pr10,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.teacher.name ?? '',
                                      style:
                                          AppTextStyle.heading5.setSemiBold(),
                                    ),
                                    Text(
                                      'Rp. ${widget.teacher.price ?? ''} /meet',
                                      style: AppTextStyle.body2
                                          .setSemiBold()
                                          .copyWith(
                                            color: AppColors.primary.pr13,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.book,
                                      color: AppColors.primary.pr13,
                                    ),
                                    Text(
                                      widget.teacher.typeTeaching ?? "",
                                      style: AppTextStyle.body3
                                          .setSemiBold()
                                          .copyWith(
                                            color: AppColors.primary.pr13,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: kMikadoYellow,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "4.5",
                                          style:
                                              AppTextStyle.body3.setSemiBold(),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '(120 Orders)',
                                          style:
                                              AppTextStyle.body3.setRegular(),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.bookmark_remove_sharp,
                                          color: AppColors.primary.pr13,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          widget.teacher.timeExperience ??
                                              '3 tahun pengalaman',
                                          style:
                                              AppTextStyle.body3.setSemiBold(),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'Ringkasan Guru :',
                                  style: AppTextStyle.body2.setSemiBold(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: ReadMoreText(
                                  widget.teacher.description ?? '',
                                  trimLines: 4,
                                  colorClickableText: Colors.pink,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: 'Show less',
                                  moreStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Divider(
                                thickness: 5,
                                color: Colors.grey.shade300,
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'Lokasi Guru :',
                                  style: AppTextStyle.body2.setSemiBold(),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: MapsWidgetDetail(
                                  lat:
                                      double.parse(widget.teacher.lat ?? '0.0'),
                                  lon:
                                      double.parse(widget.teacher.lon ?? '0.0'),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 20,
                                      color: AppColors.primary.pr10,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        widget.teacher.address ?? '0',
                                        style: AppTextStyle.body3
                                            .setRegular()
                                            .copyWith(
                                              color: AppColors.primary.pr03,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Divider(
                                thickness: 5,
                                color: Colors.grey.shade300,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ulasan Guru :',
                                      style: AppTextStyle.body1.setSemiBold(),
                                    ),
                                    Text(
                                      'Lihat Selengkapnya >',
                                      style: AppTextStyle.body3.setRegular(),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top:
                                        BorderSide(color: Colors.grey.shade300),
                                    bottom:
                                        BorderSide(color: Colors.grey.shade300),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Adung',
                                          style:
                                              AppTextStyle.body3.setSemiBold(),
                                        ),
                                        Text(
                                          '08-May-2024',
                                          style:
                                              AppTextStyle.body4.setRegular(),
                                        ),
                                        Text(
                                          'mamamammamamammamam',
                                          style:
                                              AppTextStyle.body4.setRegular(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: Colors.white,
                          height: 4,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                );
              },
              minChildSize: 0.45,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.primary.pr14),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.primary.pr13,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.primary.pr14),
                  child: IconButton(
                    onPressed: () async {
                      if (!widget.isAddedBookmark) {
                        context
                            .read<BookmarkTeacherBloc>()
                            .add(AddTeacherToBookmark(widget.teacher));
                      } else {
                        context
                            .read<BookmarkTeacherBloc>()
                            .add(RemoveTeacherFromBookmark(widget.teacher));
                      }

                      String message = "";
                      const bookmarkAddSuccessMessage = 'Added to Bookmark';
                      const bookmarkRemovedSuccessMessage =
                          'Removed to Bookmark';
                      final state =
                          BlocProvider.of<BookmarkTeacherBloc>(context).state;
                      if (state is TeacherIsAddedBookmark) {
                        final isAdded = state.isAdded;
                        message = isAdded == false
                            ? bookmarkAddSuccessMessage
                            : bookmarkRemovedSuccessMessage;
                      } else {
                        message = !widget.isAddedBookmark
                            ? bookmarkAddSuccessMessage
                            : bookmarkRemovedSuccessMessage;
                      }
                      if (message == bookmarkAddSuccessMessage ||
                          message == bookmarkRemovedSuccessMessage) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            duration: const Duration(
                              milliseconds: 1000,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(message),
                            );
                          },
                        );
                      }
                      setState(() {
                        widget.isAddedBookmark = !widget.isAddedBookmark;
                      });
                    },
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.isAddedBookmark
                            ? const Icon(
                                Icons.favorite,
                                color: pr13,
                              )
                            : const Icon(Icons.favorite_border_outlined,
                                color: pr13),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
