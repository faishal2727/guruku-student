import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/register_teacher/register_teacher_response.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/teacher/register_teacher.dart';

part 'register_teacher_event.dart';
part 'register_teacher_state.dart';

class RegisterTeacherBloc
    extends Bloc<RegisterTeacherEvent, RegisterTeacherState> {
  final RegisterTeacher register;
  final GetAuth getAuth;

  RegisterTeacherBloc({
    required this.register,
    required this.getAuth,
  }) : super(RegisterTeacherState.initial()) {
    on<DoRegisterTeacher>(
      (event, emit) async {
        emit(state.copyWith(stateRegister: ReqStateRegisTeacher.loading));
        final user = await getAuth.execute();

        final String username = event.username;
        final String email = event.email;
        final String phone = event.phone;
        final String education = event.education;
        final String jurusan = event.jurusan;
        final String tahunLulus = event.tahunLulus;
        final String idCard = event.idCard;
        final String file = event.file;

        if (user != null) {
          final result = await register.execute(
            user.token,
            username,
            email,
            phone,
            education,
            jurusan,
            tahunLulus,
            idCard,
            file,
          );
          result.fold((failure) {
            emit(
              state.copyWith(
                stateRegister: ReqStateRegisTeacher.error,
              ),
            );
          }, (data) {
            debugPrint("KODEKU $data");
            emit(
              state.copyWith(
                stateRegister: ReqStateRegisTeacher.loaded,
                registerData: data,
                message: "Berhasil Register Teacher",
              ),
            );
          });
        }
      },
    );

  }
}
