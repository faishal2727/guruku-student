part of 'order_bloc.dart';

class OrderState extends Equatable {
  final OrderResponse? orderData;
  final CancelResponse? cancelResponse;
  final String message;
  final RequestStateOrder stateOrder;
  final RequestStateOrderPackages stateOrderPackages;
  final RequestStateOrderCancel stateOrderCancel;

  const OrderState({
    required this.orderData,
    required this.cancelResponse,
    required this.message,
    required this.stateOrder,
    required this.stateOrderPackages,
    required this.stateOrderCancel,
  });

  OrderState copyWith({
    OrderResponse? orderData,
    CancelResponse? cancelResponse,
    String? message,
    RequestStateOrder? stateOrder,
    RequestStateOrderPackages? stateOrderPackages,
    RequestStateOrderCancel? stateOrderCancel,
  }) {
    return OrderState(
      orderData: orderData ?? this.orderData,
      cancelResponse: cancelResponse ?? this.cancelResponse,
      message: message ?? this.message,
      stateOrder: stateOrder ?? this.stateOrder,
      stateOrderPackages: stateOrderPackages ?? this.stateOrderPackages,
      stateOrderCancel: stateOrderCancel ?? this.stateOrderCancel,
    );
  }

  factory OrderState.initial() {
    return const OrderState(
      orderData: null,
      cancelResponse: null,
      message: " ",
      stateOrder: RequestStateOrder.initial,
      stateOrderPackages: RequestStateOrderPackages.initial,
      stateOrderCancel: RequestStateOrderCancel.initial,
    );
  }

  @override
  List<Object?> get props => [
        orderData,
        cancelResponse,
        message,
        stateOrder,
        stateOrderPackages,
        stateOrderCancel,
      ];
}
