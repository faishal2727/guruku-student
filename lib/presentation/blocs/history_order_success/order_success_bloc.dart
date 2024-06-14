import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/order/history_order_success.dart';

part 'order_success_event.dart';
part 'order_success_state.dart';

class OrderSuccessBloc extends Bloc<OrderSuccessEvent, OrderSuccessState> {
  final HistoryOrderSuccess historyOrderSuccess;
  final GetAuth getAuth;

  OrderSuccessBloc(
    this.historyOrderSuccess,
    this.getAuth,
  ) : super(OrderSuccessEmpty()) {
    on<OnOrderSuccessEvent>(_onGetOrderSuccess);
  }

  Future<void> _onGetOrderSuccess(
      OnOrderSuccessEvent event, Emitter<OrderSuccessState> emit) async {
    emit(OrderSuccessLoading());
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await historyOrderSuccess.execute(token: token.token);
      result.fold(
        (failure) {
          emit(OrderSuccessError(failure.message));
        },
        (data) {
           if (data.isEmpty) {
            emit(OrderSuccessEmpty());
          } else {
            emit(OrderSuccessHasData(data));
          }
        },
      );
    }
  }
}
