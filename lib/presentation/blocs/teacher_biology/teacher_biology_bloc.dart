import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/domain/usecase/teacher/get_teacher_biology.dart';

part 'teacher_biology_event.dart';
part 'teacher_biology_state.dart';


class TeacherBiologyBloc extends Bloc<TeacherBiologyEvent, TeacherBiologyState> {
  final GetTeacherBiology getTeacherBiology;

  TeacherBiologyBloc(this.getTeacherBiology): super(TeacherBiologyEmpty()) {
    on<OnTeacherBiologyEvent>(_onGetTeacherBiology);
  }

  Future<void> _onGetTeacherBiology(OnTeacherBiologyEvent event, Emitter<TeacherBiologyState> emit) async {
    emit(TeacherBiologyLoading());
    final result = await getTeacherBiology.execute();

    result.fold((failure) => emit(TeacherBiologyError(failure.message)), (data) {
      if(data.isEmpty){
        emit(TeacherBiologyEmpty());
      } else {
        emit(TeacherBiologyHasData(data));
      }
    });
  }
}
