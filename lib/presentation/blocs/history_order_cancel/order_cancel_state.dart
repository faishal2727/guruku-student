part of 'order_cancel_bloc.dart';

abstract class OrderCancelState extends Equatable {}

class OrderCancelLoading extends OrderCancelState {
  @override
  List<Object?> get props => [];
}

class OrderCancelError extends OrderCancelState {
  final String message;

  OrderCancelError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderCancelHasData extends OrderCancelState {
  final List<DataHistoryOrder> result;

  OrderCancelHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class OrderCancelEmpty extends OrderCancelState {
  @override
  List<Object?> get props => [];
}