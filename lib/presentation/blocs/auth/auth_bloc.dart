// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:guruku_student/common/enum_sate.dart';
// import 'package:guruku_student/domain/entity/register_response.dart';
// import 'package:guruku_student/domain/entity/verify_otp_response.dart';
// import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
// import 'package:guruku_student/domain/usecase/auth/remove_auth.dart';
// import 'package:equatable/equatable.dart';
// import 'package:guruku_student/domain/entity/login_response.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final GetAuth getAuth;
//   final RemoveAuth removeAuth;

//   AuthBloc({
//     required this.getAuth,
//     required this.removeAuth,
//   }) : super(AuthState.initial()) {
//     // cek status auth user
//     on<DoAuthCheckEvent>(
//       (event, emit) async {
//         emit(state.copyWith(state: RequestState.loading));

//         final auth = await getAuth.execute();
//         debugPrint("CEK OY $auth");

//         if (auth != null) {
//           emit(state.copyWith(
//               state: RequestState.loaded, token: auth, message: ''));
//         } else {
//           emit(state.copyWith(
//               state: RequestState.error, token: null, message: ''));
//         }
//       },
//     );

//     // logout user
//     on<DoLogoutEvent>(
//       (event, emit) async {
//         emit(state.copyWith(state: RequestState.loading));
//         await removeAuth.execute();
//         emit(
//           state.copyWith(
//             token: null,
//             state: RequestState.empty,
//             message: '',
//           ),
//         );
//       },
//     );
//   }
// }
