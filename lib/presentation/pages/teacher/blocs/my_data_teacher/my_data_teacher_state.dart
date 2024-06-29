part of 'my_data_teacher_bloc.dart';

class MyDataTeacherState extends Equatable {
  final MyDataTeacherResponse? teacher;
  final RequestStateDetail state;
  final String message;

  const MyDataTeacherState({
    this.teacher,
    required this.state,
    required this.message,
  });

  @override
  List<Object?> get props => [
        teacher,
        state,
        message,
      ];

  MyDataTeacherState copyWith({
    MyDataTeacherResponse? teacher,
    RequestStateDetail? state,
    String? message,
  }) {
    return MyDataTeacherState(
      teacher: teacher ?? this.teacher,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  factory MyDataTeacherState.initial() {
    return const MyDataTeacherState(
      teacher: null,
      state: RequestStateDetail.empty,
      message: '',
    );
  }
}
