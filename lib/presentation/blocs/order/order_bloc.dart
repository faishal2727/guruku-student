import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/order/cancel_response.dart';
import 'package:guruku_student/domain/entity/order/order_packages_request.dart';
import 'package:guruku_student/domain/entity/order/order_request.dart';
import 'package:guruku_student/domain/entity/order/order_response.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/order/order.dart';
import 'package:guruku_student/domain/usecase/order/do_cancel.dart' as t;
import 'package:guruku_student/domain/usecase/order/order_packages.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final Order order;
  final OrderPackages orderPackages;
  final t.DoCancel doCancel;
  final GetAuth getAuth;

  OrderBloc({
    required this.order,
    required this.orderPackages,
    required this.doCancel,
    required this.getAuth,
  }) : super(OrderState.initial()) {
    on<DoCancel>(
      (event, emit) async {
        emit(state.copyWith(stateOrderCancel: RequestStateOrderCancel.loading));
        final reslut = await doCancel.execute(code: event.code);

        reslut.fold((failure) {
          emit(state.copyWith(stateOrderCancel: RequestStateOrderCancel.error));
        }, (data) {
          emit(state.copyWith(
              stateOrderCancel: RequestStateOrderCancel.loaded,
              cancelResponse: data,
              message: data.message));
        });
      },
    );
    on<DoOrder>(
      (event, emit) async {
        emit(state.copyWith(stateOrder: RequestStateOrder.loading));
        final user = await getAuth.execute();

        if (user != null) {
          final request = OrderRequest(
            onBehalf: event.onBehalf,
            email: event.email,
            phone: event.phone,
            total: event.total,
            paymentType: event.paymentType,
            bankVa: event.bankVa,
            idTeacher: event.idTeacher,
            meetingDate: event.meetingDate,
            meetingTime: event.meetingTime,
            note: event.note,
            lat: event.lat,
            lon: event.lon,
            mapel: event.mapel,
          );
          final result =
              await order.execute(orderRequest: request, token: user.token);

          result.fold(
            (failure) {
              emit(state.copyWith(stateOrder: RequestStateOrder.error));
            },
            (data) {
              emit(state.copyWith(
                  stateOrder: RequestStateOrder.loaded,
                  orderData: data,
                  message: data.data.vaNumber.toString()));
            },
          );
        }
      },
    );
    on<DoOrderPackages>(
      (event, emit) async {
        emit(state.copyWith(stateOrderPackages: RequestStateOrderPackages.loading));
        final user = await getAuth.execute();

        if (user != null) {
          final request = OrderPackagesRequest(
            onBehalf: event.onBehalf,
            email: event.email,
            phone: event.phone,
            total: event.total,
            paymentType: event.paymentType,
            bankVa: event.bankVa,
            idTeacher: event.idTeacher,
            address: event.address,
            packageId: event.packageId,
            time: event.time,
            lat: event.lat,
            lon: event.lon,
            mapel: event.mapel,
          );
          final result =
              await orderPackages.execute(orderRequest: request, token: user.token);

          result.fold(
            (failure) {
              emit(state.copyWith(stateOrderPackages: RequestStateOrderPackages.error));
            },
            (data) {
              emit(state.copyWith(
                  stateOrderPackages: RequestStateOrderPackages.loaded,
                  orderData: data,
                  message: data.data.vaNumber.toString()));
            },
          );
        }
      },
    );
  }
}
