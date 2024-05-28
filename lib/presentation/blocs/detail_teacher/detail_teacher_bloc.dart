import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';
import 'package:guruku_student/domain/usecase/teacher/get_teacher_detail.dart';

part 'detail_teacher_event.dart';
part 'detail_teacher_state.dart';

class DetailTeacherBloc extends Bloc<DetailTeacherEvent, DetailTeacherState> {
  final GetTeaacherDetail getTeaacherDetail;

  DetailTeacherBloc(this.getTeaacherDetail) : super(DetailTeacherEmpty()) {
    on<OnDetailTeacherEvent>(_onDetailTeacherEvent);
  }

  Future<void> _onDetailTeacherEvent(
      OnDetailTeacherEvent event, Emitter<DetailTeacherState> emit) async {
    emit(DetailTeacherLoading());
    await Future.delayed(const Duration(seconds: 2));
    final id = event.id;
    debugPrint("YUK $id");

    final result = await getTeaacherDetail.execute(id);
    debugPrint("YUK2 $result");

    result.fold(
      (failure) {
        emit(DetailTeacherError(failure.message));
      },
      (detail) {
        emit(DetailTeacherHasData(detail));
        debugPrint("Schedule: ${detail.schedule}");
      },
    );
  }
}
