// ignore_for_file: prefer_const_constructors_in_immutables

part of 'detail_teacher_bloc.dart';

class DetailTeacherState extends Equatable {
  final TeacherDetail? teacher;
  final RequestStateDetail state;
  final String message;
  final String wishlistMessage;
  final bool isAddedToWishlist;

  const DetailTeacherState({
    this.teacher,
    required this.state,
    required this.message,
    required this.wishlistMessage,
    required this.isAddedToWishlist,
  });

  @override
  List<Object?> get props => [
        teacher,
        state,
        message,
        wishlistMessage,
        isAddedToWishlist,
      ];

  DetailTeacherState copyWith({
    TeacherDetail? teacher,
    RequestStateDetail? state,
    String? message,
    String? wishlistMessage,
    bool? isAddedToWishlist,
  }) {
    return DetailTeacherState(
      teacher: teacher ?? this.teacher,
      state: state ?? this.state,
      message: message ?? this.message,
      wishlistMessage: wishlistMessage ?? this.wishlistMessage,
      isAddedToWishlist: isAddedToWishlist ?? this.isAddedToWishlist,
    );
  }

  factory DetailTeacherState.initial() {
    return const DetailTeacherState(
      teacher: null,
      state: RequestStateDetail.empty,
      message: '',
      wishlistMessage: '',
      isAddedToWishlist: false,
    );
  }
}

// abstract class DetailTeacherState extends Equatable {
//   const DetailTeacherState();
//   @override
//   List<Object> get props => [];
// }

// class DetailTeacherLoading extends DetailTeacherState {
//   @override
//   List<Object> get props => [];
// }

// class DetailTeacherError extends DetailTeacherState {
//   final String message;

//   DetailTeacherError(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class DetailTeacherHasData extends DetailTeacherState {
//   final TeacherDetail result;

//   DetailTeacherHasData(this.result);

//   @override
//   List<Object> get props => [result];
// }

// class DetailTeacherEmpty extends DetailTeacherState {
//   @override
//   List<Object> get props => [];
// }
