part of 'order_success_bloc.dart';

abstract class OrderSuccessState extends Equatable {}

class OrderSuccessLoading extends OrderSuccessState {
  @override
  List<Object?> get props => [];
}

class OrderSuccessError extends OrderSuccessState {
  final String message;

  OrderSuccessError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderSuccessHasData extends OrderSuccessState {
  final List<DataHistoryOrder> result;

  OrderSuccessHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class OrderSuccessEmpty extends OrderSuccessState {
  @override
  List<Object?> get props => [];
}
