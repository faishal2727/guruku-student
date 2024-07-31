// ignore_for_file: unused_local_variable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/domain/entity/teacher/packages_response.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/packages/add_packages.dart';
import 'package:guruku_student/domain/usecase/packages/get_detail_packages.dart';
import 'package:guruku_student/domain/usecase/packages/get_list_packages.dart';
import 'package:guruku_student/domain/usecase/packages/get_my_packages.dart';
import 'package:guruku_student/domain/usecase/packages/update_packages.dart';

part 'packages_event.dart';
part 'packages_state.dart';

class PackagesBloc extends Bloc<PackagesEvent, PackagesState> {
  final GetListPackages listPackages;
  final GetMyPackages getMyPackages;
  final GetDetailPackages detailPackages;
  final AddPackages addPackages;
  final UpdatePackages updatePackages;
  final GetAuth getAuth;

  PackagesBloc({
    required this.listPackages,
    required this.getMyPackages,
    required this.detailPackages,
    required this.addPackages,
    required this.updatePackages,
    required this.getAuth,
  }) : super(PackagesState.initial()) {
    on<GetListPackagesEvent>(
      (event, emit) async {
        emit(state.copyWith(state: RequestStatePackages.loading));

        final result = await listPackages.execute(event.teacherId);
        debugPrint("nguntul $result");
        result.fold(
          (failure) {
            emit(state.copyWith(
              state: RequestStatePackages.error,
              message: failure.message,
            ));
          },
          (data) {
            if (data.isEmpty) {
              emit(state.copyWith(state: RequestStatePackages.empty));
            } else {
              debugPrint("nguntul $data");
              emit(state.copyWith(
                state: RequestStatePackages.loaded,
                packages: data,
              ));
            }
          },
        );
      },
    );
    on<GetListMyPackagesEvent>(
      (event, emit) async {
        emit(state.copyWith(state: RequestStatePackages.loading));
        final user = await getAuth.execute();

        if (user != null) {
          final result = await getMyPackages.execute(user.token);
          debugPrint("nguntul $result");
          result.fold(
            (failure) {
              emit(state.copyWith(
                state: RequestStatePackages.error,
                message: failure.message,
              ));
            },
            (data) {
              if (data.isEmpty) {
                emit(state.copyWith(state: RequestStatePackages.empty));
              } else {
                debugPrint("nguntul $data");
                emit(state.copyWith(
                  state: RequestStatePackages.loaded,
                  packages: data,
                ));
              }
            },
          );
        }
      },
    );
    on<OnAddDataPackages>(
      (event, emit) async {
        emit(state.copyWith(addState: RequestStateAddPackages.loading));
        final user = await getAuth.execute();

        await Future.delayed(const Duration(seconds: 2));

        final int duration = event.duration;
        final String name = event.name;
        final int price = event.price;
        final String desc = event.desc;
        final List<String> day = event.day;
        final List<String> time = event.time;
        final int teacherId = event.teacherId;

        if (user != null) {
          final result = await addPackages.execute(
            user.token,
            duration,
            name,
            price,
            desc,
            day,
            time,
            teacherId,
          );

          result.fold(
            (failure) {
              emit(state.copyWith(
                  addState: RequestStateAddPackages.error,
                  message: failure.message));
            },
            (data) {
              emit(state.copyWith(
                  addState: RequestStateAddPackages.loaded,
                  add: data,
                  message: data.message));
            },
          );
        }
      },
    );
    on<OnUpdateDataPackages>((event, emit) async {
      emit(state.copyWith(updateState: RequestStateUpdatePackages.loading));

      final int id = event.id;
      final int duration = event.duration;
      final String name = event.name;
      final int price = event.price;
      final String desc = event.desc;
      final List<String> day = event.day;
      final List<String> time = event.time;

      final result = await updatePackages.execute(
        id,
        duration,
        name,
        price,
        desc,
        day,
        time,
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
              updateState: RequestStateUpdatePackages.error,
              message: failure.message));
        },
        (data) {
          emit(state.copyWith(
              updateState: RequestStateUpdatePackages.loaded,
              update: data,
              message: data.message));
        },
      );
    });
    on<OnDetailPackagesEvent>(
      (event, emit) async {
        emit(state.copyWith(stateDetail: RequestStatePackagesDetail.loading));

        final result = await detailPackages.execute(event.id);

        result.fold(
          (failure) {
            emit(state.copyWith(
                stateDetail: RequestStatePackagesDetail.error,
                message: failure.message));
          },
          (data) {
            emit(state.copyWith(
                stateDetail: RequestStatePackagesDetail.loaded, detail: data));
          },
        );
      },
    );
  }
}
