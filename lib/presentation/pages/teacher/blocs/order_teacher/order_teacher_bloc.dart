import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_response.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/order_teacher/order_cancel_teacher.dart';
import 'package:guruku_student/domain/usecase/order_teacher/order_detail_teacher.dart';
import 'package:guruku_student/domain/usecase/order_teacher/order_done_teacher.dart';
import 'package:guruku_student/domain/usecase/order_teacher/order_pending_teacher.dart';
import 'package:guruku_student/domain/usecase/order_teacher/order_present_teacher.dart';
import 'package:guruku_student/domain/usecase/teacher/update_present.dart';

part 'order_teacher_event.dart';
part 'order_teacher_state.dart';

class OrderTeacherBloc extends Bloc<OrderTeacherEvent, OrderTeacherState> {
  final OrderPendingTeacher pendingTeacher;
  final OrderDoneTeacher doneTeacher;
  final OrderCancelTeacher cancelTeacher;
  final OrderDetailTeacher detailTeacher;
  final OrderPresentTeacher presentTeacher;
  final UpdatePresent updatePresent;
  final GetAuth getAuth;
  final UpdateTidakHadir tidakHadir;
  final UpdatePresentPackages updatePresentPackages;

  OrderTeacherBloc(
    this.pendingTeacher,
    this.doneTeacher,
    this.cancelTeacher,
    this.detailTeacher,
    this.presentTeacher,
    this.updatePresent,
    this.getAuth,
    this.tidakHadir,
    this.updatePresentPackages,
  ) : super(OrderTeacherState.initial()) {
    on<OnOrderTeacherPending>(_onGetOrderPending);
    on<OnOrderTeacherSuccess>(_onGetOrderSuccess);
    on<OnOrderTeacherCancel>(_onGetOrderCancel);
    on<OnOrderTeacherPresent>(_onGetOrderPresent);
    on<OnUpdatePresent>(_onUpdatePresent);
    on<OnUpdatePresentTidak>(_onUpdateTidak);
    on<OnOrderTeacherDetail>(_onDetailOrder);
    on<OnUpdatePresentPackage>(_onUpdatePresentPackages);
  }

  Future<void> _onGetOrderPending(
      OnOrderTeacherPending event, Emitter<OrderTeacherState> emit) async {
    emit(state.copyWith(statePending: ReqOdrTeacPen.loading));
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await pendingTeacher.execute(token: token.token);
      result.fold(
        (failure) {
          emit(state.copyWith(
              message: failure.message, statePending: ReqOdrTeacPen.error));
        },
        (data) {
          if (data.isEmpty) {
            emit(state.copyWith(statePending: ReqOdrTeacPen.empty));
          } else {
            emit(state.copyWith(
                statePending: ReqOdrTeacPen.loaded, listData: data));
          }
        },
      );
    }
  }

  Future<void> _onUpdatePresent(
      OnUpdatePresent event, Emitter<OrderTeacherState> emit) async {
    emit(state.copyWith(statePresent: ReqPresent.loading));
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await updatePresent.execute(token.token, event.id);
      result.fold(
        (failure) {
          emit(state.copyWith(
              message: failure.message, statePresent: ReqPresent.error));
        },
        (data) {
          emit(state.copyWith(
            statePresent: ReqPresent.loaded,
            present: data,
            message: data.message,
          ));
        },
      );
    }
  }

  Future<void> _onUpdatePresentPackages(
      OnUpdatePresentPackage event, Emitter<OrderTeacherState> emit) async {
    emit(state.copyWith(pac: ReqPresentPac.loading));
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await updatePresentPackages.execute(
        token.token,
        event.orderId,
        event.packageId,
        event.status,
      );
      result.fold(
        (failure) {
          emit(state.copyWith(
              message: failure.message, pac: ReqPresentPac.error));
        },
        (data) {
          emit(state.copyWith(
            pac: ReqPresentPac.loaded,
            presentPac: data,
            message: data.message,
          ));
        },
      );
    }
  }

  Future<void> _onUpdateTidak(
      OnUpdatePresentTidak event, Emitter<OrderTeacherState> emit) async {
    emit(state.copyWith(statePresent: ReqPresent.loading));
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await tidakHadir.execute(token.token, event.id);
      result.fold(
        (failure) {
          emit(state.copyWith(
              message: failure.message, statePresent: ReqPresent.error));
        },
        (data) {
          emit(state.copyWith(
            statePresent: ReqPresent.loaded,
            present: data,
            message: data.message,
          ));
        },
      );
    }
  }

  Future<void> _onGetOrderSuccess(
      OnOrderTeacherSuccess event, Emitter<OrderTeacherState> emit) async {
    emit(state.copyWith(stateSuccess: ReqOdrTeacSuc.loading));
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await doneTeacher.execute(token: token.token);
      result.fold(
        (failure) {
          emit(state.copyWith(
              stateSuccess: ReqOdrTeacSuc.error, message: failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(state.copyWith(stateSuccess: ReqOdrTeacSuc.empty));
          } else {
            emit(state.copyWith(
                stateSuccess: ReqOdrTeacSuc.loaded, listData: data));
          }
        },
      );
    }
  }

  Future<void> _onGetOrderCancel(
      OnOrderTeacherCancel event, Emitter<OrderTeacherState> emit) async {
    emit(state.copyWith(stateCancel: ReqOdrTeacCan.loading));
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await cancelTeacher.execute(token: token.token);
      result.fold(
        (failure) {
          emit(state.copyWith(
              stateCancel: ReqOdrTeacCan.error, message: failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(state.copyWith(stateCancel: ReqOdrTeacCan.empty));
          } else {
            emit(state.copyWith(
                stateCancel: ReqOdrTeacCan.loaded, listData: data));
          }
        },
      );
    }
  }

  Future<void> _onGetOrderPresent(
      OnOrderTeacherPresent event, Emitter<OrderTeacherState> emit) async {
    emit(state.copyWith(stateDone: ReqOdrTeacDone.loading));
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await presentTeacher.execute(token: token.token);
      result.fold(
        (failure) {
          emit(state.copyWith(
              stateDone: ReqOdrTeacDone.error, message: failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(state.copyWith(stateDone: ReqOdrTeacDone.empty));
          } else {
            emit(state.copyWith(
                stateDone: ReqOdrTeacDone.loaded, listData: data));
          }
        },
      );
    }
  }

  Future<void> _onDetailOrder(
      OnOrderTeacherDetail event, Emitter<OrderTeacherState> emit) async {
    emit(state.copyWith(stateDetail: ReqOdrTeacDetail.loading));

    final token = await getAuth.execute();
    debugPrint("Token: ${token?.token}");

    if (token!.token.isNotEmpty) {
      final result = await detailTeacher.execute(
        token: token.token,
        idTeacher: event.idTeacher,
        idOrder: event.idOrder,
      );
      result.fold(
        (failure) {
          emit(state.copyWith(
              stateDetail: ReqOdrTeacDetail.error, message: failure.message));
        },
        (data) {
          debugPrint("CEK DATA: ${data.toString()}");
          emit(state.copyWith(
              stateDetail: ReqOdrTeacDetail.loaded, detailData: data));
        },
      );
    }
  }
}
