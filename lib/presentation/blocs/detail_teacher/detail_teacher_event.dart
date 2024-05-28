part of 'detail_teacher_bloc.dart';

abstract class DetailTeacherEvent extends Equatable {}

class OnDetailTeacherEvent extends DetailTeacherEvent {
  final int id;

  OnDetailTeacherEvent(this.id);

  @override
  List<Object> get props => [id];
}
