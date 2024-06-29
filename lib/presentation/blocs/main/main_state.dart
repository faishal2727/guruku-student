// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_bloc.dart';

class MainState extends Equatable {
  final String role;
  final bool isLogin;

  const MainState({
    required this.role,
    required this.isLogin,
  });

  MainState copyWith({
    int? tabIndex,
    String? role,
    bool? isLogin,
  }) {
    return MainState(
      role: role ?? this.role,
      isLogin: isLogin ?? this.isLogin,
    );
  }

  factory MainState.initial() => const MainState(
        role: '',
        isLogin: false,
      );

  @override
  List<Object> get props => [role, isLogin];
}
