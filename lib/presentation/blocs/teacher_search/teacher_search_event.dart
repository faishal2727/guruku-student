// ignore_for_file: prefer_const_constructors_in_immutables

part of 'teacher_search_bloc.dart';

abstract class TeacherSearchEvent extends Equatable {
  const TeacherSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends TeacherSearchEvent {
  final String query;

  OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
