import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/notif/notif_response.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/notif/get_notif_student.dart';

part 'notif_event.dart';
part 'notif_state.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  final GetNotifStudent getNotifStudent;
  final GetAuth getAuth;

  NotifBloc(
    this.getNotifStudent,
    this.getAuth,
  ) : super(NotifState.initial()) {
    on<OnGetNotifEvent>(_onGetNotif);
  }
  Future<void> _onGetNotif(
      OnGetNotifEvent event, Emitter<NotifState> emit) async {
    emit(state.copyWith(state: ReqStateNotif.loading));
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result =
          await getNotifStudent.execute(token.token);
      result.fold(
        (failure) {
          emit(state.copyWith(
              message: failure.message, state: ReqStateNotif.error));
        },
        (data) {
          if (data.isEmpty) {
            emit(state.copyWith(state: ReqStateNotif.empty));
          } else {
            emit(state.copyWith(
                state: ReqStateNotif.loaded, listData: data));
          }
        },
      );
    }
  }
}
