import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/domain/usecase/teacher/get_teacher_indonesian.dart';

part 'teacher_indo_event.dart';
part 'teacher_indo_state.dart';


class TeacherIndoBloc extends Bloc<TeacherIndoEvent, TeacherIndoState> {
  final GetTeacherIndonesian getTeacherIndo;

  TeacherIndoBloc(this.getTeacherIndo): super(TeacherIndoEmpty()) {
    on<OnTeacherIndoEvent>(_onGetTeacherIndo);
  }

  Future<void> _onGetTeacherIndo(OnTeacherIndoEvent event, Emitter<TeacherIndoState> emit) async {
    emit(TeacherIndoLoading());
    final result = await getTeacherIndo.execute();

    result.fold((failure) => emit(TeacherIndoError(failure.message)), (data) {
      if(data.isEmpty){
        emit(TeacherIndoEmpty());
      } else {
        emit(TeacherIndoHasData(data));
      }
    });
  }
}
