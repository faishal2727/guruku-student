part of 'detail_order_bloc.dart';

abstract class DetailOrderState extends Equatable {
  const DetailOrderState();
  @override
  List<Object> get props => [];
}


class DetailOrderLoading extends DetailOrderState {
  @override
  List<Object> get props => [];
}

class DetailOrderError extends DetailOrderState {
  final String message;

  DetailOrderError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailOrderHasData extends DetailOrderState {
  final DetailHistoryOrder result;

  // ignore: prefer_const_constructors_in_immutables
  DetailOrderHasData(this.result);

  @override
  List<Object> get props => [result];
}

class DetailOrderEmpty extends DetailOrderState {
  @override
  List<Object> get props => [];
}

