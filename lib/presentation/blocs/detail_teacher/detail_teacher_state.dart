// ignore_for_file: prefer_const_constructors_in_immutables

part of 'detail_teacher_bloc.dart';

abstract class DetailTeacherState extends Equatable {
  const DetailTeacherState();
  @override
  List<Object> get props => [];
}

class DetailTeacherLoading extends DetailTeacherState {
  @override
  List<Object> get props => [];
}

class DetailTeacherError extends DetailTeacherState {
  final String message;

  DetailTeacherError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTeacherHasData extends DetailTeacherState {
  final TeacherDetail result;

  DetailTeacherHasData(this.result);

  @override
  List<Object> get props => [result];
}

class DetailTeacherEmpty extends DetailTeacherState {
  @override
  List<Object> get props => [];
}
