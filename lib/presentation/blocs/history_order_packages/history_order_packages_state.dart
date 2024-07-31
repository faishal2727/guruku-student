part of 'history_order_packages_bloc.dart';

abstract class HistoryOrderPackagesState extends Equatable {}

class OrderPackagesLoading extends HistoryOrderPackagesState {
  @override
  List<Object?> get props => [];
}

class OrderPackagesError extends HistoryOrderPackagesState {
  final String message;

  OrderPackagesError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderPackagesHasData extends HistoryOrderPackagesState {
  final List<DataHistoryOrderPackagesUye> result;

  OrderPackagesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class OrderPackagesEmpty extends HistoryOrderPackagesState {
  @override
  List<Object?> get props => [];
}

class OrderPackagesTeacherLoading extends HistoryOrderPackagesState {
  @override
  List<Object?> get props => [];
}

class OrderPackagesTeacherError extends HistoryOrderPackagesState {
  final String message;

  OrderPackagesTeacherError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderPackagesTeacherHasData extends HistoryOrderPackagesState {
  final List<DataHistoryOrderPackagesUye> result;

  OrderPackagesTeacherHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class OrderPackagesTeacherEmpty extends HistoryOrderPackagesState {
  @override
  List<Object?> get props => [];
}
