import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/teacher/get_my_data_teacher.dart';

part 'my_data_teacher_event.dart';
part 'my_data_teacher_state.dart';

class MyDataTeacherBloc extends Bloc<MyDataTeacherEvent, MyDataTeacherState> {
  final GetAuth getAuth;
  final GetMyDataTeacher myDataTeacher;

  MyDataTeacherBloc({
    required this.getAuth,
    required this.myDataTeacher,
  }) : super(MyDataTeacherState.initial()) {
    on<OnMyDataTeacherEvent>(
      (event, emit) async {
        emit(state.copyWith(state: RequestStateDetail.loading));
        final user = await getAuth.execute();

        if (user != null) {
          final int teacherId = event.id;
          final String token = user.token;
          final result = await myDataTeacher.execute(
            token: token,
            id: teacherId,
          );
          result.fold(
            (failure) {
              emit(state.copyWith(
                  state: RequestStateDetail.error, message: failure.message));
            },
            (data) {
              emit(state.copyWith(
                  state: RequestStateDetail.loaded, teacher: data));
            },
          );
        }
      },
    );
  }
}
