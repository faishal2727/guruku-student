part of 'bookmark_teacher_bloc.dart';

abstract class BookmarkTeacherEvent extends Equatable {}

class OnGetBookmarkTeacher extends BookmarkTeacherEvent {
  @override
  List<Object> get props => [];
}

class FetchBookmarkTeacherStatus extends BookmarkTeacherEvent {
  final int id;

  FetchBookmarkTeacherStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddTeacherToBookmark extends BookmarkTeacherEvent {
  final TeacherDetail teacher;

  AddTeacherToBookmark(this.teacher);

  @override
  List<Object> get props => [teacher];
}

class RemoveTeacherFromBookmark extends BookmarkTeacherEvent {
  final TeacherDetail teacher;

  RemoveTeacherFromBookmark(this.teacher);

  @override
  List<Object> get props => [teacher];
}
