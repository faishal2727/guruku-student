import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/order/get_all_present.dart';
import 'package:guruku_student/domain/usecase/order/get_all_tidak_hadir.dart';

part 'get_present_event.dart';
part 'get_present_state.dart';

class GetPresentBloc extends Bloc<GetPresentEvent, GetPresentState> {
  final GetAllPresent getAllPresent;
  final GetAllTidakHadir getAllTidakHadir;
  final GetAuth getAuth;

  GetPresentBloc(
    this.getAllPresent,
    this.getAuth,
    this.getAllTidakHadir,
  ) : super(GetPresentStateEmpty()) {
    on<OnGetPresentEvent>(_onGetOrderSuccess);
     on<OnGetPresentTidakEvent>(_onGetTidakHadir);
  }

  Future<void> _onGetOrderSuccess(
      OnGetPresentEvent event, Emitter<GetPresentState> emit) async {
    emit(GetPresentStateLoading());
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await getAllPresent.execute(token: token.token);
      result.fold(
        (failure) {
          emit(GetPresentStateError(failure.message));
        },
        (data) {
           if (data.isEmpty) {
            emit(GetPresentStateEmpty());
          } else {
            emit(GetPresentStateHasData(data));
          }
        },
      );
    }
  }

  Future<void> _onGetTidakHadir(
      OnGetPresentTidakEvent event, Emitter<GetPresentState> emit) async {
    emit(GetPresentTidakLoading());
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await getAllTidakHadir.execute(token: token.token);
      result.fold(
        (failure) {
          emit(GetPresentStateError(failure.message));
        },
        (data) {
           if (data.isEmpty) {
            emit(GetPresentTidakEmpty());
          } else {
            emit(GetPresentTidakHasData(data));
          }
        },
      );
    }
  }
}