import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/domain/usecase/teacher/get_teacher_english.dart';

part 'teacher_english_event.dart';
part 'teacher_english_state.dart';


class TeacherEnglishBloc extends Bloc<TeacherEnglishEvent, TeacherEnglishState> {
  final GetTeacherEnglish getTeacherEnglish;

  TeacherEnglishBloc(this.getTeacherEnglish): super(TeacherEnglishEmpty()) {
    on<OnTeacherEnglishEvent>(_onGetTeacherEnglish);
  }

  Future<void> _onGetTeacherEnglish(OnTeacherEnglishEvent event, Emitter<TeacherEnglishState> emit) async {
    emit(TeacherEnglishLoading());
    final result = await getTeacherEnglish.execute();

    result.fold((failure) => emit(TeacherEnglishError(failure.message)), (data) {
      if(data.isEmpty){
        emit(TeacherEnglishEmpty());
      } else {
        emit(TeacherEnglishHasData(data));
      }
    });
  }
}

