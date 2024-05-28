part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  final PaymentResponse? paymentData;
  final String message;
  final RequestStatePayment statePayment;

  const PaymentState({
    required this.paymentData,
    required this.message,
    required this.statePayment,
  });

  PaymentState copyWith({
    PaymentResponse? paymentData,
    String? message,
    RequestStatePayment? statePayment,
  }) {
    return PaymentState(
      paymentData: paymentData ?? this.paymentData,
      message: message ?? this.message,
      statePayment: statePayment ?? this.statePayment,
    );
  }

  factory PaymentState.initial() {
    return const PaymentState(
      paymentData: null,
      message: " ",
      statePayment: RequestStatePayment.initial,
    );
  }

  @override
  List<Object?> get props => [
        paymentData,
        message,
        statePayment,
      ];
}
