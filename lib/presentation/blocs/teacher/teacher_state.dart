part of 'teacher_bloc.dart';

abstract class TeacherState extends Equatable {}

class TeacherLoading extends TeacherState {
  @override
  List<Object> get props => [];
}

class TeacherError extends TeacherState {
  final String message;

  TeacherError(this.message);

  @override
  List<Object> get props => [message];
}

class TeacherHasData extends TeacherState {
  final List<Teacher> result;

  TeacherHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TeacherEmpty extends TeacherState {
  @override
  List<Object> get props => [];
}
