part of 'notif_bloc.dart';

abstract class NotifEvent extends Equatable {}

class OnGetNotifEvent extends NotifEvent {
  OnGetNotifEvent();
  @override
  List<Object?> get props => [];
}
