import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/order/history_order_pending.dart';

part 'order_pending_event.dart';
part 'order_pending_state.dart';

class OrderPendingBloc extends Bloc<OrderPendingEvent, OrderPendingState> {
  final HistoryOrderPending historyOrderPending;
  final GetAuth getAuth;

  OrderPendingBloc(
    this.historyOrderPending,
    this.getAuth,
  ) : super(OrderPendingEmpty()) {
    on<OnOrderPendingEvent>(_onGetOrderPending);
  }

  Future<void> _onGetOrderPending(
      OnOrderPendingEvent event, Emitter<OrderPendingState> emit) async {
    emit(OrderPendingLoading());
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await historyOrderPending.execute(token: token.token);
      result.fold(
        (failure) {
          emit(OrderPendingError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(OrderPendingEmpty());
          } else {
            emit(OrderPendingHasData(data));
          }
        },
      );
    }
  }
}
