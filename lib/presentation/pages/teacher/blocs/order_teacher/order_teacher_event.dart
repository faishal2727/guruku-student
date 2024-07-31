// ignore_for_file: must_be_immutable

part of 'order_teacher_bloc.dart';

abstract class OrderTeacherEvent extends Equatable {}

class OnOrderTeacherPending extends OrderTeacherEvent {
  OnOrderTeacherPending();
  @override
  List<Object?> get props => [];
}

class OnOrderTeacherSuccess extends OrderTeacherEvent {
  OnOrderTeacherSuccess();
  @override
  List<Object?> get props => [];
}

class OnOrderTeacherCancel extends OrderTeacherEvent {
  OnOrderTeacherCancel();
  @override
  List<Object?> get props => [];
}

class OnOrderTeacherPresent extends OrderTeacherEvent {
  OnOrderTeacherPresent();
  @override
  List<Object?> get props => [];
}

class OnUpdatePresent extends OrderTeacherEvent {
  int id;
  OnUpdatePresent(this.id);
  @override
  List<Object?> get props => [id];
}

class OnUpdatePresentPackage extends OrderTeacherEvent {
  int packageId;
  int orderId;
  String status;
  OnUpdatePresentPackage(this.packageId, this.orderId, this.status);
  @override
  List<Object?> get props => [packageId, orderId, status,];
}

class OnUpdatePresentTidak extends OrderTeacherEvent {
  int id;
  OnUpdatePresentTidak(this.id);
  @override
  List<Object?> get props => [id];
}

class OnOrderTeacherDetail extends OrderTeacherEvent {
  final int idTeacher;
  final int idOrder;

  OnOrderTeacherDetail(
    this.idTeacher,
    this.idOrder,
  );

  @override
  List<Object?> get props => [idTeacher, idOrder];
}
