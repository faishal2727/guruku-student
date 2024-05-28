part of 'teacher_biology_bloc.dart';

abstract class TeacherBiologyState extends Equatable {}

class TeacherBiologyLoading extends TeacherBiologyState {
  @override
  List<Object> get props => [];
}

class TeacherBiologyError extends TeacherBiologyState {
  final String message;

  TeacherBiologyError(this.message);

  @override
  List<Object> get props => [message];
}

class TeacherBiologyHasData extends TeacherBiologyState {
  final List<Teacher> result;

  TeacherBiologyHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TeacherBiologyEmpty extends TeacherBiologyState {
  @override
  List<Object> get props => [];
}