import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/payment/payment_response.dart';
import 'package:guruku_student/domain/usecase/payment/payment.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final Payment payment;

  PaymentBloc({
    required this.payment,
  }) : super(PaymentState.initial()) {
    on<DoPayment>(
      (event, emit) async {
        emit(state.copyWith(statePayment: RequestStatePayment.loading));
        final int orderId = event.orderId;
        final int total = event.total;
        final String name = event.name;

        final result = await payment.execute(
          orderId: orderId,
          total: total,
          name: name,
        );
        result.fold(
          (failure) =>
              emit(state.copyWith(statePayment: RequestStatePayment.error)),
          (data) {
            debugPrint('TOKEN SNAP = ${data.token}');
            emit(
              state.copyWith(
                  statePayment: RequestStatePayment.loaded,
                  paymentData: data,
                  message: 'Berhasil Mendapatkan Token Snap'),
            );
          },
        );
      },
    );
  }
}
