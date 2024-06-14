part of 'order_pending_bloc.dart';

abstract class OrderPendingState extends Equatable {}

class OrderPendingLoading extends OrderPendingState {
  @override
  List<Object?> get props => [];
}

class OrderPendingError extends OrderPendingState {
  final String message;

  OrderPendingError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderPendingHasData extends OrderPendingState {
  final List<DataHistoryOrder> result;

  OrderPendingHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class OrderPendingEmpty extends OrderPendingState {
  @override
  List<Object?> get props => [];
}
