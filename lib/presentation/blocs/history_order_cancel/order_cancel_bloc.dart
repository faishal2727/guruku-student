import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/order/history_order_cancel.dart';

part 'order_cancel_event.dart';
part 'order_cancel_state.dart';


class OrderCancelBloc extends Bloc<OrderCancelEvent, OrderCancelState> {
  final HistoryOrderCancel historyOrderCancel;
  final GetAuth getAuth;

  OrderCancelBloc(
    this.historyOrderCancel,
    this.getAuth,
  ) : super(OrderCancelEmpty()) {
    on<OnOrderCancelEvent>(_onGetOrderCancel);
  }

  Future<void> _onGetOrderCancel(
      OnOrderCancelEvent event, Emitter<OrderCancelState> emit) async {
    emit(OrderCancelLoading());
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await historyOrderCancel.execute(token: token.token);
      result.fold(
        (failure) {
          emit(OrderCancelError(failure.message));
        },
        (data) {
         if (data.isEmpty) {
          emit(OrderCancelEmpty());
        } else {
          emit(OrderCancelHasData(data));
        }
        },
      );
    }
  }
}
