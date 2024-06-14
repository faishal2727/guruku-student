part of 'order_bloc.dart';

class OrderState extends Equatable {
  final OrderResponse? orderData;
  final String message;
  final RequestStateOrder stateOrder;

  const OrderState({
    required this.orderData,
    required this.message,
    required this.stateOrder,
  });

  OrderState copyWith({
    OrderResponse? orderData,
    String? message,
    RequestStateOrder? stateOrder,
  }) {
    return OrderState(
      orderData: orderData ?? this.orderData,
      message: message ?? this.message,
      stateOrder: stateOrder ?? this.stateOrder,
    );
  }

  factory OrderState.initial() {
    return const OrderState(
      orderData: null,
      message: " ",
      stateOrder: RequestStateOrder.initial,
    );
  }
  
  @override
  List<Object?> get props => [
    orderData,
    message,
    stateOrder,
  ];
}
