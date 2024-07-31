import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order_packages_uye.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/order/history_order_packages.dart';
import 'package:guruku_student/domain/usecase/order_teacher/order_pending_teacher.dart';

part 'history_order_packages_event.dart';
part 'history_order_packages_state.dart';

class HistoryOrderPackagesBloc
    extends Bloc<HistoryOrderPackagesEvent, HistoryOrderPackagesState> {
  final HistoryOrderPackages historyOrderPackages;
  final OrderPackageTeacher orderPackageTeacher;
  final GetAuth getAuth;

  HistoryOrderPackagesBloc(
    this.historyOrderPackages,
    this.orderPackageTeacher,
    this.getAuth,
  ) : super(OrderPackagesEmpty()) {
    on<OnOrderPackagesEvent>(_onGetOrderPackages);
    on<OnOrderPackagesTeacherEvent>(_onGetOrderTeacherPackages);
  }

  Future<void> _onGetOrderPackages(OnOrderPackagesEvent event,
      Emitter<HistoryOrderPackagesState> emit) async {
    emit(OrderPackagesLoading());
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await historyOrderPackages.execute(token: token.token);
      result.fold(
        (failure) {
          emit(OrderPackagesError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(OrderPackagesEmpty());
          } else {
            emit(OrderPackagesHasData(data));
          }
        },
      );
    }
  }

  Future<void> _onGetOrderTeacherPackages(OnOrderPackagesTeacherEvent event,
      Emitter<HistoryOrderPackagesState> emit) async {
    emit(OrderPackagesTeacherLoading());
    final token = await getAuth.execute();
    if (token!.token.isNotEmpty) {
      final result = await orderPackageTeacher.execute(token: token.token);
      result.fold(
        (failure) {
          emit(OrderPackagesTeacherError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(OrderPackagesTeacherEmpty());
          } else {
            emit(OrderPackagesTeacherHasData(data));
          }
        },
      );
    }
  }
}
