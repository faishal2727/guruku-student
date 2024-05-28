import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/domain/usecase/bookmark/get_bookmark_status.dart';
import 'package:guruku_student/domain/usecase/bookmark/get_bookmark_teacher_list.dart';
import 'package:guruku_student/domain/usecase/bookmark/remove_bookmark_teacher.dart';
import 'package:guruku_student/domain/usecase/bookmark/save_bookmark_teacher.dart';

part 'bookmark_teacher_event.dart';
part 'bookmark_teacher_state.dart';

class BookmarkTeacherBloc
    extends Bloc<BookmarkTeacherEvent, BookmarkTeacherState> {
  static const bookmarkAddSuccessMessage = 'Added to Bookmark';
  static const bookmarkRemoveSuccessMessage = 'Removed from Bookmark';

  final GetBookmarkTeacherList _getBookmarkTeacherList;
  final GetBookmarkStatus _getBookmarkStatus;
  final RemoveBookmarkTeacher _removeBookmarkTeacher;
  final SaveBookmarkTeacher _saveBookmarkTeacher;

  BookmarkTeacherBloc(
    this._getBookmarkTeacherList,
    this._getBookmarkStatus,
    this._removeBookmarkTeacher,
    this._saveBookmarkTeacher,
  ) : super(BookmarkTeacherInitial()) {
    on<OnGetBookmarkTeacher>(_fetchTeacherBookmark);
    on<FetchBookmarkTeacherStatus>(_fetchBookmarkStatus);
    on<AddTeacherToBookmark>(_addTeacherToBookmark);
    on<RemoveTeacherFromBookmark>(_removeTeacherFromBookmark);
  }

  Future<void> _fetchTeacherBookmark(
    OnGetBookmarkTeacher event,
    Emitter<BookmarkTeacherState> emit,
  ) async {
    emit(BookmarkTeacherLoading());
    await Future.delayed(const Duration(seconds: 2));
    final result = await _getBookmarkTeacherList.execute();

    result.fold(
      (failure) {
        emit(BookmarkTeacherError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(BookmarkTeacherEmpty())
            : emit(BookmarkTeacherHasData(data));
      },
    );
  }

  Future<void> _fetchBookmarkStatus(
    FetchBookmarkTeacherStatus event,
    Emitter<BookmarkTeacherState> emit,
  ) async {
    final id = event.id;

    final result = await _getBookmarkStatus.execute(id);

    emit(TeacherIsAddedBookmark(result));
  }

  Future<void> _addTeacherToBookmark(
    AddTeacherToBookmark event,
    Emitter<BookmarkTeacherState> emit,
  ) async {
    final teacher = event.teacher;

    final result = await _saveBookmarkTeacher.execute(teacher);

    result.fold(
      (failure) {
        emit(BookmarkTeacherError(failure.message));
      },
      (message) {
        emit(BookmarkTeacherMessage(message));
      },
    );
  }

  Future<void> _removeTeacherFromBookmark(
    RemoveTeacherFromBookmark event,
    Emitter<BookmarkTeacherState> emit,
  ) async {
    final teacher = event.teacher;

    final result = await _removeBookmarkTeacher.execute(teacher);

    result.fold(
      (failure) {
        emit(BookmarkTeacherError(failure.message));
      },
      (message) {
        emit(BookmarkTeacherMessage(message));
      },
    );
  }
}
