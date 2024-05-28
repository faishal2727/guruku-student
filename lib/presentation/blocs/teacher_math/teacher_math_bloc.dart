import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/domain/usecase/teacher/get_teacher_math.dart';

part 'teacher_math_event.dart';
part 'teacher_math_state.dart';

class TeacherMathBloc extends Bloc<TeacherMathEvent, TeacherMathState> {
  final GetTeacherMath getTeacherMath;

  TeacherMathBloc(this.getTeacherMath) : super(TeacherMathEmpty()) {
    on<OnTeacherMathEvent>(_onGetTeacherMath);
  }

  Future<void> _onGetTeacherMath(
      OnTeacherMathEvent event, Emitter<TeacherMathState> emit) async {
    emit(TeacherMathLoading());
   
    final result = await getTeacherMath.execute();

    result.fold((failure) => emit(TeacherMathError(failure.message)), (data) {
      if (data.isEmpty) {
        emit(TeacherMathEmpty());
      } else {
        emit(TeacherMathHasData(data));
      }
    });
  }
}
