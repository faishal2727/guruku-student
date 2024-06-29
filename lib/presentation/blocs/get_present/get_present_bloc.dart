import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/order/get_all_present.dart';

part 'get_present_event.dart';
part 'get_present_state.dart';

class GetPresentBloc extends Bloc<GetPresentEvent, GetPresentState> {
  final GetAllPresent getAllPresent;
  final GetAuth getAuth;

  GetPresentBloc(
    this.getAllPresent,
    this.getAuth,
  ) : super(GetPresentStateEmpty()) {
    on<OnGetPresentEvent>(_onGetOrderSuccess);
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
}