part of 'detail_order_bloc.dart';

abstract class DetailOrderEvent extends Equatable {}

class OnDetailOrderEvent extends DetailOrderEvent {
  final int id;

  OnDetailOrderEvent(this.id);

  @override
  List<Object?> get props => [id];
}
