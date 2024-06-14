// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:guruku_student/presentation/blocs/detail_teacher/detail_teacher_bloc.dart';
// import 'package:lottie/lottie.dart';

// class OrderPage extends StatefulWidget {
//   final int id;
//   const OrderPage({
//     super.key,
//     required this.id,
//   });

//   @override
//   State<OrderPage> createState() => _OrderPageState();
// }

// class _OrderPageState extends State<OrderPage> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       context.read<DetailTeacherBloc>().add(OnDetailTeacherEvent(widget.id));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<DetailTeacherBloc, DetailTeacherState>(
//         builder: (context, state) {
//           if (state is DetailTeacherLoading) {
//             return Center(
//               child: Lottie.asset('assets/lotties/loading_state.json',
//                   height: 180, width: 180),
//             );
//           } else if (state is DetailTeacherHasData) {
//             final teacher = state.result;
//           } else if (state is DetailTeacherEmpty) {
//             return const Text(
//               'empty',
//               key: Key('empty_message'),
//             );
//           } else {
//             return const Text(
//               'error',
//               key: Key('error_message'),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
