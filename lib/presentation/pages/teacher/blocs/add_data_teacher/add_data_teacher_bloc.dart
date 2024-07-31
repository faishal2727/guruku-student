import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/register_teacher/add_data_teacher_response.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/teacher/add_data_teacher.dart';
import 'package:guruku_student/domain/usecase/teacher/pick_schedule.dart';

part 'add_data_teacher_event.dart';
part 'add_data_teacher_state.dart';

class AddDataTeacherBloc
    extends Bloc<AddDataTeacherEvent, AddDataTeacherState> {
  final AddDataTeacher addDataTeacher;
  final PickSchedule pickSchedule;
  final GetAuth getAuth;

  AddDataTeacherBloc(
    this.addDataTeacher,
    this.getAuth,
    this.pickSchedule,
  ) : super(AddDataTeacherState.initial()) {
    on<OnPickSchedule>(_onPickSchedule);
    on<OnAddDataTeacher>(_onAddDataTeacher);
  }

  _onPickSchedule(
      OnPickSchedule event, Emitter<AddDataTeacherState> emit) async {
    emit(state.copyWith(stateSchedule: ReqStateSchedule.loading));
    final user = await getAuth.execute();
    await Future.delayed(const Duration(seconds: 2));
    final List<Map<String, dynamic>> schedule = event.schedule;

    if (user != null) {
      final result = await pickSchedule.execute(user.token, schedule);
      result.fold(
        (failure) {
          emit(state.copyWith(
              stateSchedule: ReqStateSchedule.error, message: failure.message));
        },
        (data) {
          emit(state.copyWith(
              stateSchedule: ReqStateSchedule.loaded,
              data: data,
              message: data.message));
        },
      );
    }
  }

  _onAddDataTeacher(
      OnAddDataTeacher event, Emitter<AddDataTeacherState> emit) async {
    emit(state.copyWith(state: ReqStateTeacher.loading));
    final user = await getAuth.execute();

    await Future.delayed(const Duration(seconds: 2));

    final String picture = event.picture;
    final String name = event.name;
    final String desc = event.desc;
    final String price = event.price;
    final List<String> typeTeaching = event.typeTeaching;
    final String timeExperience = event.timeExperience;
    final String lat = event.lat;
    final String lon = event.lon;
    final String address = event.address;
    final List<String> skill = event.skill;

    if (user != null) {
      final result = await addDataTeacher.execute(picture, user.token, name,
          desc, typeTeaching, price, timeExperience, lat, lon, address, skill);

      result.fold(
        (failure) {
          emit(state.copyWith(
              state: ReqStateTeacher.error, message: failure.message));
        },
        (data) {
          emit(state.copyWith(
              state: ReqStateTeacher.loaded,
              data: data,
              message: data.message));
        },
      );
    }
  }
}
