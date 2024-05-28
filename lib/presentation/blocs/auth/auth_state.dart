// part of 'auth_bloc.dart';

// class AuthState extends Equatable {
//   final RequestState state;
//   final LoginResponse? token;

//   final String message;

//   const AuthState({
//     required this.state,
//     required this.token,
//     required this.message,
//   });

//   AuthState copyWith({
//     LoginResponse? token,
//     RegisterResponse? registerData,
//     VerifyOtpResponse? verifyOtpData,
//     RequestState? state,
//     String? message,
//   }) {
//     return AuthState(

//       state: state ?? this.state,
//       token: token ?? this.token,
//       message: message ?? this.message,
//     );
//   }

//   factory AuthState.initial() {
//     return const AuthState(
//       state: RequestState.initial,
//       token: null,
//       message: 'uyuhk',
//     );
//   }

//   @override
//   List<Object?> get props => [
//         state,
//         message,
//       ];
// }
