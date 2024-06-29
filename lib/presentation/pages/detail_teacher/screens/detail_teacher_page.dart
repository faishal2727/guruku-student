// ignore_for_file: constant_identifier_names, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/injection.dart' as di;
import 'package:guruku_student/presentation/blocs/detail_teacher/detail_teacher_bloc.dart';
import 'package:guruku_student/presentation/blocs/main/main_bloc.dart';
import 'package:guruku_student/presentation/pages/detail_teacher/widgets/detail_content.dart';
import 'package:guruku_student/presentation/pages/pick_schedule/screen/pick.dart';
import 'package:lottie/lottie.dart';

class DetailTeacherPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';
  final int id;
  DetailTeacherPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailTeacherPage> createState() => _DetailTeacherPageState();
}

class _DetailTeacherPageState extends State<DetailTeacherPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.locator<DetailTeacherBloc>()
        ..add(OnDetailTeacherEvent(widget.id))
        ..add(LoadWishlistStatusEvent(widget.id)),
      child: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          body: BlocConsumer<DetailTeacherBloc, DetailTeacherState>(
            listener: (context, state) {
             final message = state.wishlistMessage;

              if (message == DetailTeacherBloc.wishlistAddSuccessMessage ||
                  message == DetailTeacherBloc.wishlistRemoveSuccessMessage) {
                _scaffoldMessengerKey.currentState!
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(message)));
              } else {
                _scaffoldMessengerKey.currentState!
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red[400],
                  ));
              }
            },
            listenWhen: (oldState, newState) {
              return oldState.wishlistMessage != newState.wishlistMessage &&
                  newState.wishlistMessage != '';
            },
            builder: (context, state) {
              if (state.state == RequestStateDetail.loading) {
                return Center(
                  child: Lottie.asset(
                    'assets/lotties/loading_state.json',
                    height: 180,
                    width: 180,
                  ),
                );
              }
              if (state.state == RequestStateDetail.loaded) {
                return DetailContent(
                  teacher: state.teacher!,
                  isAddedToWishlist: state.isAddedToWishlist,
                );
              }
              if (state.state == RequestStateDetail.error) {
                return Center(
                  child: Text(state.message),
                );
              }
              return Container();
            },
          ),
          bottomNavigationBar: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                height: 80,
              ),
              BlocBuilder<MainBloc, MainState>(
                builder: (context, authState) {
                  return Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () async {
                        Navigator.pushNamed(
                          context,
                          Pick.ROUTE_NAME,
                          arguments: widget.id,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primary.pr13),
                        child: Center(
                          child: Text(
                            'Atur Pertemuan',
                            style: AppTextStyle.body1
                                .setRegular()
                                .copyWith(color: AppColors.primary.pr11),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class DetailTeacherPage extends StatefulWidget {
//   static const ROUTE_NAME = '/detail';
//   final int id;
//   DetailTeacherPage({
//     super.key,
//     required this.id,
//   });

//   @override
//   State<DetailTeacherPage> createState() => _DetailTeacherPageState();
// }

// class _DetailTeacherPageState extends State<DetailTeacherPage> {
//   bool isMeetingButtonVisible = true;

//   void setMeetingButtonVisibility(bool isVisible) {
//     setState(() {
//       isMeetingButtonVisible = isVisible;
//     });
//   }

//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => di.locator<DetailTeacherBloc>()
//         ..add(OnDetailTeacherEvent(widget.id))
//         ..add(LoadWishlistStatusEvent(widget.id)),
//       child: ScaffoldMessenger(
//         key: _scaffoldMessengerKey,
//         child: Scaffold(
//           body: BlocConsumer<DetailTeacherBloc, DetailTeacherState>(
//             listener: (context, state) {
//               final message = state.wishlistMessage;
//               if (message == DetailTeacherBloc.wishlistAddSuccessMessage ||
//                   message == DetailTeacherBloc.wishlistRemoveSuccessMessage) {
//                 _scaffoldMessengerKey.currentState!
//                   ..hideCurrentSnackBar()
//                   ..showSnackBar(SnackBar(content: Text(message)));
//               } else {
//                 _scaffoldMessengerKey.currentState!
//                   ..hideCurrentSnackBar()
//                   ..showSnackBar(SnackBar(content: Text(message)));
//               }
//             },
//             listenWhen: (oldState, newState) {
//               return oldState.wishlistMessage != newState.wishlistMessage &&
//                   newState.wishlistMessage != '';
//             },
//             builder: (context, state) {
//               if (state.state == RequestStateDetail.loading) {
//                 return Center(
//                   child: Lottie.asset(
//                     'assets/lotties/loading_state.json',
//                     height: 180,
//                     width: 180,
//                   ),
//                 );
//               }
//               if (state.state == RequestStateDetail.loaded) {
//                 return DetailContent(
//                   teacher: state.teacher!,
//                   isAddedToWishlist: state.isAddedToWishlist,
//                 );
//               }
//               if (state.state == RequestStateDetail.error) {
//                 return Center(
//                   child: Text(state.message),
//                 );
//               }
//               return Container();
//             },
//           ),
//           bottomNavigationBar: Stack(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       topRight: Radius.circular(8)),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       spreadRadius: 3,
//                       blurRadius: 5,
//                       offset: const Offset(0, -2),
//                     ),
//                   ],
//                 ),
//                 height: 80,
//               ),
//               Expanded(
//                 flex: 3,
//                 child: InkWell(
//                   onTap: () async {
                    
                    
//                       Navigator.pushNamed(
//                         context,
//                         Pick.ROUTE_NAME,
//                         arguments: widget.id,
//                       );
                    
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 16),
//                     height: 50,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: AppColors.primary.pr13,
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Atur Pertemuan',
//                         style: AppTextStyle.body1
//                             .setRegular()
//                             .copyWith(color: AppColors.primary.pr11),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DetailTeacherPage extends StatefulWidget {
//   static const ROUTE_NAME = '/detail';
//   final int id;
//   const DetailTeacherPage({super.key, required this.id});

//   @override
//   State<DetailTeacherPage> createState() => _DetailTeacherPageState();
// }

// class _DetailTeacherPageState extends State<DetailTeacherPage> {
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       context.read<DetailTeacherBloc>().add(OnDetailTeacherEvent(widget.id));
//       context
//           .read<BookmarkTeacherBloc>()
//           .add(FetchBookmarkTeacherStatus(widget.id));
//     });
//   }

//   void _retry() async {
//     setState(() {
//       _isLoading = true;
//     });
//     await Future.delayed(const Duration(seconds: 2));
//     context.read<DetailTeacherBloc>().add(OnDetailTeacherEvent(widget.id));
//     context
//         .read<BookmarkTeacherBloc>()
//         .add(FetchBookmarkTeacherStatus(widget.id));
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isAddedToBookmark = context.select<BookmarkTeacherBloc, bool>(
//       (bloc) => (bloc.state is TeacherIsAddedBookmark)
//           ? (bloc.state as TeacherIsAddedBookmark).isAdded
//           : false,
//     );
//     return Scaffold(
//       backgroundColor: AppColors.primary.pr12,
//       body: BlocBuilder<DetailTeacherBloc, DetailTeacherState>(
//         builder: (context, state) {
//           if (state.state == RequestStateDetail.loading) {
//             return Center(
//               child: Lottie.asset(
//                 'assets/lotties/loading_state.json',
//                 height: 180,
//                 width: 180,
//               ),
//             );
//           } else if (state.state == RequestStateDetail.loaded) {
//             final teacher = state.teacher;
//             return DetailContent(
//               teacher!,
//               isAddedToBookmark,
//             );
//           } else if (state.state == RequestStateDetail.empty) {
//             return const EmptySection();
//           } else if (state.state == RequestStateDetail.error) {
//             return ErrorSection(
//                 isLoading: _isLoading,
//                 onPressed: _retry,
//                 message: state.message);
//           } else {
//             return const SizedBox();
//           }
//         },
//       ),
//       bottomNavigationBar: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(8), topRight: Radius.circular(8)),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   spreadRadius: 3,
//                   blurRadius: 5,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             height: 80,
//           ),
//           Expanded(
//             flex: 3,
//             child: InkWell(
//               onTap: () async {
//                 final isLogin = context.read<MainBloc>().state.isLogin;
//                 if (isLogin) {
//                   Navigator.pushNamed(
//                     context,
//                     Pick.ROUTE_NAME,
//                     arguments: widget.id,
//                   );
//                 } else {
//                   final String? result = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const LoginPage(),
//                     ),
//                   );
//                   if (result != null &&
//                       result == GlobalVariables.successLogin) {
//                     if (!mounted) return;
//                     Navigator.pushNamed(
//                       context,
//                       Pick.ROUTE_NAME,
//                       arguments: widget.id,
//                     );
//                   }
//                 }
//               },
//               child: Container(
//                 margin:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 height: 50,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: AppColors.primary.pr13,
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Atur Pertemuan',
//                     style: AppTextStyle.body1
//                         .setRegular()
//                         .copyWith(color: AppColors.primary.pr11),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
