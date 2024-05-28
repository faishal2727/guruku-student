part of 'teacher_math_bloc.dart';

abstract class TeacherMathState extends Equatable {}

class TeacherMathLoading extends TeacherMathState {
  @override
  List<Object> get props => [];
}

class TeacherMathError extends TeacherMathState {
  final String message;

  TeacherMathError(this.message);

  @override
  List<Object> get props => [message];
}

class TeacherMathHasData extends TeacherMathState {
  final List<Teacher> result;

  TeacherMathHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TeacherMathEmpty extends TeacherMathState {
  @override
  List<Object> get props => [];
}