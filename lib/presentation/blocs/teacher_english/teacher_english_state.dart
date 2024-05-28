part of 'teacher_english_bloc.dart';

abstract class TeacherEnglishState extends Equatable {}

class TeacherEnglishLoading extends TeacherEnglishState {
  @override
  List<Object> get props => [];
}

class TeacherEnglishError extends TeacherEnglishState {
  final String message;

  TeacherEnglishError(this.message);

  @override
  List<Object> get props => [message];
}

class TeacherEnglishHasData extends TeacherEnglishState {
  final List<Teacher> result;

  TeacherEnglishHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TeacherEnglishEmpty extends TeacherEnglishState {
  @override
  List<Object> get props => [];
}