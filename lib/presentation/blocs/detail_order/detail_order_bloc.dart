import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order_package.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/order/get_detail_order.dart';

part 'detail_order_event.dart';
part 'detail_order_state.dart';

class DetailOrderBloc extends Bloc<DetailOrderEvent, DetailOrderState> {
  final GetDetailOrder getDetailOrder;
  final GetDetailOrderPackages getDetailOrderPackages;
  final GetAuth getAuth;

  DetailOrderBloc(this.getDetailOrder,this.getDetailOrderPackages, this.getAuth)
      : super(DetailOrderEmpty()) {
    on<OnDetailOrderEvent>(_onDetailOrder);
    on<OnDetailOrderPackagesEvent>(_onDetailOrderPackages);
  }

  Future<void> _onDetailOrder(
      OnDetailOrderEvent event, Emitter<DetailOrderState> emit) async {
    emit(DetailOrderLoading());
    final id = event.id;
    final token = await getAuth.execute();
    debugPrint("Token: ${token?.token}");

    debugPrint("metikan $id");

    if (token!.token.isNotEmpty) {
      final result = await getDetailOrder.execute(token: token.token, id: id);
      result.fold(
        (failure) {
          emit(DetailOrderError(failure.message));
        },
        (data) {
          debugPrint("CEK DATA: ${data.toString()}");
          emit(DetailOrderHasData(data));
        },
      );
    }
  }
   Future<void> _onDetailOrderPackages(
      OnDetailOrderPackagesEvent event, Emitter<DetailOrderState> emit) async {
    emit(DetailOrderPackagesLoading());
    final id = event.id;
    final token = await getAuth.execute();
    debugPrint("Token: ${token?.token}");

    debugPrint("metikan $id");

    if (token!.token.isNotEmpty) {
      final result = await getDetailOrderPackages.execute(token: token.token, id: id);
      result.fold(
        (failure) {
          emit(DetailOrderPackagesError(failure.message));
        },
        (data) {
          debugPrint("CEK DATA: ${data.toString()}");
          emit(DetailOrderPackagesHasData(data));
        },
      );
    }
  }
}
