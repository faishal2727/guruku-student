part of 'teacher_indo_bloc.dart';

abstract class TeacherIndoState extends Equatable {}

class TeacherIndoLoading extends TeacherIndoState {
  @override
  List<Object> get props => [];
}

class TeacherIndoError extends TeacherIndoState {
  final String message;

  TeacherIndoError(this.message);

  @override
  List<Object> get props => [message];
}

class TeacherIndoHasData extends TeacherIndoState {
  final List<Teacher> result;

  TeacherIndoHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TeacherIndoEmpty extends TeacherIndoState {
  @override
  List<Object> get props => [];
}