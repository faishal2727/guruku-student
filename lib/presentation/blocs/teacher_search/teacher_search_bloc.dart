import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/usecase/teacher/get_search_teacher.dart';
import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';

part 'teacher_search_event.dart';
part 'teacher_search_state.dart';

class TeacherSearchBloc extends Bloc<TeacherSearchEvent, TeacherSearchState> {
  final GetSearchTeacher getSearchTeacher;

  TeacherSearchBloc(this.getSearchTeacher) : super(SearchTeacherEmpty()) {
    on<OnQueryChanged>(_onSearchTeacher);
  }

  Future<void> _onSearchTeacher(
      OnQueryChanged event, Emitter<TeacherSearchState> emit) async {
    emit(SearchTeacherLoading());

    final name = event.query;

    final result = await getSearchTeacher.execute(name);

    result.fold(
      (failure) {
        emit(SearchTeacherError(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(SearchTeacherEmpty());
        } else {
          emit(SearchTeacherHasData(data));
        }
      },
    );
  }
}
