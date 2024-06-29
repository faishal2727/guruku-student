part of 'detail_teacher_bloc.dart';

sealed class DetailTeacherEvent extends Equatable {
  const DetailTeacherEvent();

  @override
  List<Object> get props => [];
}

final class OnDetailTeacherEvent extends DetailTeacherEvent {
  final int id;

  const OnDetailTeacherEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class AddWishlistEvent extends DetailTeacherEvent {
  final int idTeacher;

  const AddWishlistEvent({
    required this.idTeacher,
  });

  @override
  List<Object> get props => [idTeacher];
}

final class LoadWishlistStatusEvent extends DetailTeacherEvent {
  final int id;

  const LoadWishlistStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class RemoveWishlistEvent extends DetailTeacherEvent {
  final int id;

  const RemoveWishlistEvent(this.id);

  @override
  List<Object> get props => [id];
}

