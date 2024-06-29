import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/domain/usecase/teacher/get_all_teacher.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final GetAllTeacher getAllTeacher;

  TeacherBloc(this.getAllTeacher) : super(TeacherEmpty()) {
    on<OnTeacherEvent>(_onGetTeacher);
  }
  Future<void> _onGetTeacher(
      OnTeacherEvent event, Emitter<TeacherState> emit) async {
    emit(TeacherLoading());
    await Future.delayed(const Duration(seconds: 2));

    final result = await getAllTeacher.execute();

    result.fold(
      (failure) => emit(TeacherError(failure.message)),
      (data) {
        if (data.isEmpty) {
          emit(TeacherEmpty());
        } else {
          emit(TeacherHasData(data));
        }
      },
    );
  }
}
