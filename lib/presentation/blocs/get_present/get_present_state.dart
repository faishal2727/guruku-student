part of 'get_present_bloc.dart';


abstract class GetPresentState extends Equatable {}

class GetPresentStateLoading extends GetPresentState {
  @override
  List<Object?> get props => [];
}

class GetPresentStateError extends GetPresentState {
  final String message;

  GetPresentStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetPresentStateHasData extends GetPresentState {
  final List<DataHistoryOrder> result;

  GetPresentStateHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class GetPresentStateEmpty extends GetPresentState {
  @override
  List<Object?> get props => [];
}

class GetPresentTidakLoading extends GetPresentState {
  @override
  List<Object?> get props => [];
}

class GetPresentTidakError extends GetPresentState {
  final String message;

  GetPresentTidakError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetPresentTidakHasData extends GetPresentState {
  final List<DataHistoryOrder> result;

  GetPresentTidakHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class GetPresentTidakEmpty extends GetPresentState {
  @override
  List<Object?> get props => [];
}

