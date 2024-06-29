part of 'notif_bloc.dart';

class NotifState extends Equatable {
  final List<NotifResponse>? listData;
  final String message;
  final ReqStateNotif state;

  const NotifState({
    required this.listData,
    required this.message,
    required this.state,
  });

  NotifState copyWith({
    List<NotifResponse>? listData,
    String? message,
    ReqStateNotif? state,
  }) {
    return NotifState(
      listData: listData ?? this.listData,
      message: message ?? this.message,
      state: state ?? this.state,
    );
  }

  factory NotifState.initial() {
    return const NotifState(
      listData: null,
      message: "",
      state: ReqStateNotif.empty,
    );
  }

  @override
  List<Object?> get props => [
        listData,
        message,
        state,
      ];
}
