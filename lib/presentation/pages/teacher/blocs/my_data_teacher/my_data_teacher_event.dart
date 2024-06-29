part of 'my_data_teacher_bloc.dart';

sealed class MyDataTeacherEvent extends Equatable {
  const MyDataTeacherEvent();

  @override
  List<Object> get props => [];
}

final class OnMyDataTeacherEvent extends MyDataTeacherEvent {
  final int id;

  const OnMyDataTeacherEvent(this.id);

  @override
  List<Object> get props => [id];
}