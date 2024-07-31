import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_detail_response.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_response.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/withdraw/get_detail_wd.dart';
import 'package:guruku_student/domain/usecase/withdraw/list_wd_student.dart';
import 'package:guruku_student/domain/usecase/withdraw/list_wd_teacher.dart';
import 'package:guruku_student/domain/usecase/withdraw/withdraw.dart';

part 'withdraw_event.dart';
part 'withdraw_state.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  final Withdraw withdraw;
  final ListWdTeacher listWdTeacher;
  final ListWdStudent listWdStudent;
  final GetDetailWd getDetailWd;
  final GetAuth getAuth;

  WithdrawBloc({
    required this.withdraw,
    required this.listWdTeacher,
    required this.listWdStudent,
    required this.getDetailWd,
    required this.getAuth,
  }) : super(WithdrawState.initial()) {
    on<ReqWd>((event, emit) async {
      emit(state.copyWith(stateWd: RequestStateWd.loading));
      final user = await getAuth.execute();

      if (user != null) {
        try {
          final result = await withdraw.execute(user.token, event.idTeacher,
              event.amount, event.noBank, event.bankName);
          result.fold(
            (failure) {
              emit(state.copyWith(
                  stateWd: RequestStateWd.error, message: failure.message));
            },
            (data) {
              emit(state.copyWith(stateWd: RequestStateWd.loaded));
            },
          );
        } catch (e) {
          if (e is WDException) {
            emit(state.copyWith(
                stateWd: RequestStateWd.error, message: e.message));
          } else {
            emit(state.copyWith(
                stateWd: RequestStateWd.error,
                message: 'Unknown error occurred'));
          }
        }
      }
    });

    on<OnListWdTeacher>(
      (event, emit) async {
        emit(state.copyWith(stateListWd: ReqStateListWd.loading));

        final user = await getAuth.execute();

        if (user != null) {
          final String token = user.token;
          final int idTeacher = event.idTeacher;

          final result = await listWdTeacher.execute(
            token,
            idTeacher,
          );

          result.fold(
            (failure) {
              emit(
                state.copyWith(
                  stateListWd: ReqStateListWd.error,
                  message: failure.message,
                ),
              );
            },
            (data) {
              if (data.isEmpty) {
                emit(
                  state.copyWith(
                    stateListWd: ReqStateListWd.empty,
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    stateListWd: ReqStateListWd.loaded,
                    dataList: data,
                  ),
                );
              }
            },
          );
        }
      },
    );

    on<OnListWdStudent>(
      (event, emit) async {
        emit(state.copyWith(stateListWdStudent: ReqStateListWdStudent.loading));

        final user = await getAuth.execute();

        if (user != null) {
          final String token = user.token;

          final result = await listWdStudent.execute(token);

          result.fold(
            (failure) {
              emit(
                state.copyWith(
                  stateListWdStudent: ReqStateListWdStudent.error,
                  message: failure.message,
                ),
              );
            },
            (data) {
              if (data.isEmpty) {
                emit(
                  state.copyWith(
                    stateListWdStudent: ReqStateListWdStudent.empty,
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    stateListWdStudent: ReqStateListWdStudent.loaded,
                    dataList: data,
                  ),
                );
              }
            },
          );
        }
      },
    );
    on<OnDetailWd>(
      (event, emit) async {
        emit(state.copyWith(stateWdDetail: ReqStateWdDetail.loading));
        final user = await getAuth.execute();

        if (user != null) {
          final result = await getDetailWd.execute(user.token, event.id);

          result.fold(
            (failure) {
              emit(state.copyWith(stateWdDetail: ReqStateWdDetail.error));
            },
            (data) {
              emit(state.copyWith(
                  stateWdDetail: ReqStateWdDetail.loaded,
                  dataDetail: data,
                  message: 'Sukses Mendapatkan Detail'));
            },
          );
        }
      },
    );
  }
}
