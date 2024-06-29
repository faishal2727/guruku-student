part of 'add_data_teacher_bloc.dart';

class AddDataTeacherState extends Equatable {
  final AddDataTeacherResponse? data;
  final String message;
  final ReqStateTeacher state;
  final ReqStateSchedule stateSchedule;

  const AddDataTeacherState({
    required this.data,
    required this.message,
    required this.state,
    required this.stateSchedule,
  });

  AddDataTeacherState copyWith({
    AddDataTeacherResponse? data,
    String? message,
    ReqStateTeacher? state,
    ReqStateSchedule? stateSchedule,
  }) {
    return AddDataTeacherState(
      data: data ?? this.data,
      message: message ?? this.message,
      state: state ?? this.state,
      stateSchedule: stateSchedule ?? this.stateSchedule,
    );
  }

  factory AddDataTeacherState.initial() {
    return const AddDataTeacherState(
      data: null,
      message: '',
      state: ReqStateTeacher.initial,
      stateSchedule: ReqStateSchedule.initial,
    );
  }

  @override
  List<Object?> get props => [
        data,
        message,
        state,
        stateSchedule
      ];
}
