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

class OrderCanceledLoading extends OrderCancelState {
  @override
  List<Object?> get props => [];
}

class OrderCanceledError extends OrderCancelState {
  final String message;

  OrderCanceledError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderCanceledHasData extends OrderCancelState {
  final List<DataHistoryOrder> result;

  OrderCanceledHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class OrderCanceledEmpty extends OrderCancelState {
  @override
  List<Object?> get props => [];
}