import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/order/order_request.dart';
import 'package:guruku_student/domain/entity/order/order_response.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/order/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final Order order;
  final GetAuth getAuth;

  OrderBloc({
    required this.order,
    required this.getAuth,
  }) : super(OrderState.initial()) {
    on<DoOrder>(
      (event, emit) async {
        emit(state.copyWith(stateOrder: RequestStateOrder.loading));
        final user = await getAuth.execute();

        if (user != null) {
          final request = OrderRequest(
            onBehalf: event.onBehalf,
            email: event.email,
            phone: event.phone,
            total: event.total,
            paymentType: event.paymentType,
            bankVa: event.bankVa,
            idTeacher: event.idTeacher,
            meetingDate: event.meetingDate,
            meetingTime: event.meetingTime,
            note: event.note,
          );
          final result = await order.execute(
            orderRequest: request,
            token: user.token,
          );

          result.fold(
            (failure) {
              emit(state.copyWith(stateOrder: RequestStateOrder.error));
            },
            (data) {
              emit(
                state.copyWith(
                  stateOrder: RequestStateOrder.loaded,
                  orderData: data,
                  message: data.data.vaNumber.toString(),
                ),
              );
            },
          );
        }
      },
    );
  }
}
