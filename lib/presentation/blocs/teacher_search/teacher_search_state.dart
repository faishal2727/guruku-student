part of 'teacher_search_bloc.dart';

abstract class TeacherSearchState extends Equatable {
  const TeacherSearchState();

  @override
  List<Object> get props => [];
}

class SearchTeacherEmpty extends TeacherSearchState{}

class SearchTeacherLoading extends TeacherSearchState{}

class SearchTeacherError extends TeacherSearchState{
  final String message;

  SearchTeacherError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTeacherHasData extends TeacherSearchState{
  final List<Teacher> result;

  SearchTeacherHasData(this.result);

   @override
  List<Object> get props => [result];
}