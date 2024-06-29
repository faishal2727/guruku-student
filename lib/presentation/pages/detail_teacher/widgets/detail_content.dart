// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/shared_widgets/empty_section.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';
import 'package:guruku_student/presentation/blocs/detail_teacher/detail_teacher_bloc.dart';
import 'package:guruku_student/presentation/blocs/review/review_bloc.dart';
import 'package:guruku_student/presentation/pages/detail_teacher/widgets/maps_widgets_detail.dart';
import 'package:guruku_student/presentation/pages/review_list/screens/list_review_page.dart';
import 'package:guruku_student/presentation/pages/review_list/widgets/card_review.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';

class DetailContent extends StatefulWidget {
  final TeacherDetail teacher;
  final bool isAddedToWishlist;

  const DetailContent({
    super.key,
    required this.teacher,
    required this.isAddedToWishlist,
  });

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ReviewBloc>().add(GetListReviewEvent(widget.teacher.id));
      context
          .read<DetailTeacherBloc>()
          .add(LoadWishlistStatusEvent(widget.teacher.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  widget.teacher.picture != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: widget.teacher.picture!,
                            fit: BoxFit.fill,
                            width: 280,
                            height: 350,
                            placeholder: (context, url) => Center(
                              child: Lottie.asset(
                                  'assets/lotties/loading_state.json',
                                  height: 180,
                                  width: 180),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.warning, color: Colors.red),
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
                    child: widget.teacher.picture != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: widget.teacher.picture!,
                              fit: BoxFit.fill,
                              width: 280,
                              height: 350,
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
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.white,
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
                                          widget.teacher.rate ?? '0',
                                          style:
                                              AppTextStyle.body3.setRegular(),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "(${widget.teacher.histories.length.toString()} Order)",
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
                              const SizedBox(height: 16),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'Detail Pendidikan Guru :',
                                  style: AppTextStyle.body2.setSemiBold(),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Gelar : ${widget.teacher.gelar}',
                                      style: AppTextStyle.body4.setMedium(),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Jurusan : ${widget.teacher.jurusan}',
                                      style: AppTextStyle.body4.setMedium(),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Tahun Lulus : ${widget.teacher.tahunLulus}',
                                      style: AppTextStyle.body4.setMedium(),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Divider(
                                thickness: 10,
                                color: pr16,
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
                                thickness: 10,
                                color: pr16,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, ListReviewPage.ROUTE_NAME,
                                            arguments: widget.teacher.id);
                                      },
                                      child: Text(
                                        'Lihat Semua >',
                                        style: AppTextStyle.body3
                                            .setRegular()
                                            .copyWith(color: pr13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 420,
                                child: BlocBuilder<ReviewBloc, ReviewState>(
                                  builder: (context, state) {
                                    if (state.state ==
                                        RequestStateReview.loading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state.state ==
                                        RequestStateReview.loaded) {
                                      int itemCount = state.review != null
                                          ? (state.review!.length < 3
                                              ? state.review!.length
                                              : 3)
                                          : 0;
                                      return ListView.builder(
                                        itemCount: itemCount,
                                        itemBuilder: (context, index) {
                                          final data = state.review![index];
                                          return CardReview(review: data);
                                        },
                                      );
                                    } else if (state.state ==
                                        RequestStateReview.error) {
                                      return const Text('Error');
                                    } else if (state.state ==
                                        RequestStateReview.empty) {
                                      return const EmptySection();
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ),
                              Divider(
                                thickness: 10,
                                color: pr16,
                              ),
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
                child: BlocBuilder<DetailTeacherBloc, DetailTeacherState>(
                  builder: (context, state) {
                    final isAddedToWishlist = state.isAddedToWishlist;
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.primary.pr14),
                      child: IconButton(
                        onPressed: () {
                          if (!isAddedToWishlist) {
                            context.read<DetailTeacherBloc>().add(
                                  AddWishlistEvent(
                                    idTeacher: widget.teacher.id,
                                  ),
                                );
                          } else {
                            context.read<DetailTeacherBloc>().add(
                                  RemoveWishlistEvent(widget.teacher.id),
                                );
                          }
                        },
                        icon: Icon(
                          isAddedToWishlist
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.pink,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



// class DetailContent extends StatefulWidget {
//   final TeacherDetail teacher;
//   final bool isAddedToWishlist;

//   const DetailContent({
//     super.key,
//     required this.teacher,
//     required this.isAddedToWishlist,
//   });

//   @override
//   State<DetailContent> createState() => _DetailContentState();
// }

// class _DetailContentState extends State<DetailContent> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       context.read<ReviewBloc>().add(GetListReviewEvent(widget.teacher.id));
//     });

//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Stack(
//         children: [
//           Stack(
//             children: [
//               Stack(
//                 children: [
//                   widget.teacher.picture != null
//                       ? ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: CachedNetworkImage(
//                             imageUrl: widget.teacher.picture!,
//                             fit: BoxFit.fill,
//                             width: 280,
//                             height: 350,
//                             placeholder: (context, url) => Center(
//                               child: Lottie.asset(
//                                   'assets/lotties/loading_state.json',
//                                   height: 180,
//                                   width: 180),
//                             ),
//                             errorWidget: (context, url, error) => const Center(
//                               child: Icon(Icons.error, color: Colors.red),
//                             ),
//                           ),
//                         )
//                       : const Center(
//                           child: Icon(Icons.warning, color: Colors.red),
//                         ),
//                   Container(
//                     color: const Color.fromARGB(255, 111, 111, 111)
//                         .withOpacity(0.3),
//                   ),
//                   BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                     child: Container(
//                       color: const Color.fromARGB(13, 51, 51, 51),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 50),
//                 child: Align(
//                   alignment: Alignment.topCenter,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(24),
//                     child: widget.teacher.picture != null
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: CachedNetworkImage(
//                               imageUrl: widget.teacher.picture!,
//                               fit: BoxFit.fill,
//                               width: 280,
//                               height: 350,
//                               placeholder: (context, url) => Center(
//                                 child: Lottie.asset(
//                                     'assets/lotties/loading_state.json',
//                                     height: 180,
//                                     width: 180),
//                               ),
//                               errorWidget: (context, url, error) =>
//                                   const Center(
//                                 child: Icon(Icons.error, color: Colors.red),
//                               ),
//                             ),
//                           )
//                         : const Center(
//                             child: Icon(Icons.warning, color: Colors.red),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 48 + 8),
//             child: DraggableScrollableSheet(
//               builder: (context, scrollController) {
//                 return Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(24),
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       Container(
//                         color: Colors.white,
//                         margin: const EdgeInsets.only(top: 16),
//                         child: SingleChildScrollView(
//                           controller: scrollController,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Center(
//                                 child: Container(
//                                   height: 5,
//                                   width: 50,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     color: AppColors.primary.pr10,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 24),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 16),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       widget.teacher.name ?? '',
//                                       style:
//                                           AppTextStyle.heading5.setSemiBold(),
//                                     ),
//                                     Text(
//                                       'Rp. ${widget.teacher.price ?? ''} /meet',
//                                       style: AppTextStyle.body2
//                                           .setSemiBold()
//                                           .copyWith(
//                                             color: AppColors.primary.pr13,
//                                           ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16.0),
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.book,
//                                       color: AppColors.primary.pr13,
//                                     ),
//                                     Text(
//                                       widget.teacher.typeTeaching ?? "",
//                                       style: AppTextStyle.body3
//                                           .setSemiBold()
//                                           .copyWith(
//                                             color: AppColors.primary.pr13,
//                                           ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 8),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.star,
//                                           color: kMikadoYellow,
//                                         ),
//                                         const SizedBox(width: 4),
//                                         Text(
//                                           widget.teacher.rate ?? "0",
//                                           style:
//                                               AppTextStyle.body3.setSemiBold(),
//                                         ),
//                                         const SizedBox(width: 4),
//                                         Text(
//                                           "(${widget.teacher.histories.length.toString()} Order)",
//                                           style:
//                                               AppTextStyle.body3.setRegular(),
//                                         )
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.bookmark_remove_sharp,
//                                           color: AppColors.primary.pr13,
//                                         ),
//                                         const SizedBox(width: 4),
//                                         Text(
//                                           widget.teacher.timeExperience ??
//                                               '3 tahun pengalaman',
//                                           style:
//                                               AppTextStyle.body3.setSemiBold(),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               const SizedBox(height: 8),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 16),
//                                 child: Text(
//                                   'Ringkasan Guru :',
//                                   style: AppTextStyle.body2.setSemiBold(),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 8),
//                                 child: ReadMoreText(
//                                   widget.teacher.description ?? '',
//                                   trimLines: 4,
//                                   colorClickableText: Colors.pink,
//                                   trimMode: TrimMode.Line,
//                                   trimCollapsedText: 'Show more',
//                                   trimExpandedText: 'Show less',
//                                   moreStyle: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Divider(
//                                 thickness: 10,
//                                 color: pr16,
//                               ),
//                               const SizedBox(height: 8),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 16),
//                                 child: Text(
//                                   'Lokasi Guru :',
//                                   style: AppTextStyle.body2.setSemiBold(),
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Container(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 16),
//                                 height: 250,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: MapsWidgetDetail(
//                                   lat:
//                                       double.parse(widget.teacher.lat ?? '0.0'),
//                                   lon:
//                                       double.parse(widget.teacher.lon ?? '0.0'),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16.0),
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.location_on,
//                                       size: 20,
//                                       color: AppColors.primary.pr10,
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Expanded(
//                                       child: Text(
//                                         widget.teacher.address ?? '0',
//                                         style: AppTextStyle.body3
//                                             .setRegular()
//                                             .copyWith(
//                                               color: AppColors.primary.pr03,
//                                             ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Divider(
//                                 thickness: 10,
//                                 color: pr16,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 16),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Ulasan Guru :',
//                                       style: AppTextStyle.body1.setSemiBold(),
//                                     ),
//                                     InkWell(
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                             context, ListReviewPage.ROUTE_NAME,
//                                             arguments: widget.teacher.id);
//                                       },
//                                       child: Text(
//                                         'Lihat Semua >',
//                                         style: AppTextStyle.body3
//                                             .setRegular()
//                                             .copyWith(color: pr13),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 420,
//                                 child: BlocBuilder<ReviewBloc, ReviewState>(
//                                   builder: (context, state) {
//                                     if (state.state ==
//                                         RequestStateReview.loading) {
//                                       return const Center(
//                                         child: CircularProgressIndicator(),
//                                       );
//                                     } else if (state.state ==
//                                         RequestStateReview.loaded) {
//                                       int itemCount = state.review != null
//                                           ? (state.review!.length < 3
//                                               ? state.review!.length
//                                               : 3)
//                                           : 0;
//                                       return ListView.builder(
//                                         itemCount: itemCount,
//                                         itemBuilder: (context, index) {
//                                           final data = state.review![index];
//                                           return CardReview(review: data);
//                                         },
//                                       );
//                                     } else if (state.state ==
//                                         RequestStateReview.error) {
//                                       return const Text('Error');
//                                     } else if (state.state ==
//                                         RequestStateReview.empty) {
//                                       return const EmptySection();
//                                     } else {
//                                       return const SizedBox();
//                                     }
//                                   },
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 10,
//                                 color: pr16,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.topCenter,
//                         child: Container(
//                           color: Colors.white,
//                           height: 4,
//                           width: 48,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               minChildSize: 0.45,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       color: AppColors.primary.pr14),
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.arrow_back_ios_new,
//                       color: AppColors.primary.pr13,
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       color: AppColors.primary.pr14),
//                   child: IconButton(
//                     onPressed: () {
//                       if (!widget.isAddedToWishlist) {
//                         context.read<DetailTeacherBloc>().add(
//                               AddWishlistEvent(idTeacher: widget.teacher.id),
//                             );
//                       } else {
//                         context
//                             .read<DetailTeacherBloc>()
//                             .add(RemoveWishlistEvent(widget.teacher.id));
//                       }
//                     },
//                     icon: Icon(
//                       widget.isAddedToWishlist
//                           ? Icons.favorite
//                           : Icons.favorite_border,
//                       color: Colors.pink,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }