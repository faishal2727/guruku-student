part of 'order_teacher_bloc.dart';

class OrderTeacherState extends Equatable {
  final List<DataHistoryOrder>? listData;
  final DetailHistoryOrder? detailData;
  final UpdateProfileResponse? present;
  final UpdateProfileResponse? presentPac;
  final String message;
  final ReqOdrTeacPen statePending;
  final ReqOdrTeacSuc stateSuccess;
  final ReqOdrTeacDetail stateDetail;
  final ReqOdrTeacCan stateCancel;
  final ReqOdrTeacDone stateDone;
  final ReqPresent statePresent;
  final ReqTidak tidak;
  final ReqPresentPac pac;

  const OrderTeacherState({
    required this.listData,
    required this.detailData,
    required this.present,
    required this.presentPac,
    required this.message,
    required this.statePending,
    required this.stateSuccess,
    required this.stateDetail,
    required this.stateCancel,
    required this.stateDone,
    required this.statePresent,
    required this.tidak,
    required this.pac,
  });

  OrderTeacherState copyWith({
    List<DataHistoryOrder>? listData,
    DetailHistoryOrder? detailData,
    UpdateProfileResponse? present,
    UpdateProfileResponse? presentPac,
    String? message,
    ReqOdrTeacPen? statePending,
    ReqOdrTeacSuc? stateSuccess,
    ReqOdrTeacDetail? stateDetail,
    ReqOdrTeacCan? stateCancel,
    ReqOdrTeacDone? stateDone,
    ReqPresent? statePresent,
    ReqTidak? tidak,
    ReqPresentPac? pac,
  }) {
    return OrderTeacherState(
      listData: listData ?? this.listData,
      detailData: detailData ?? this.detailData,
      present: present ?? this.present,
      presentPac: presentPac ?? this.presentPac,
      message: message ?? this.message,
      statePending: statePending ?? this.statePending,
      stateSuccess: stateSuccess ?? this.stateSuccess,
      stateDetail: stateDetail ?? this.stateDetail,
      stateCancel: stateCancel ?? this.stateCancel,
      stateDone: stateDone ?? this.stateDone,
      statePresent: statePresent ?? this.statePresent,
      tidak: tidak ?? this.tidak,
      pac: pac ?? this.pac,
    );
  }

  factory OrderTeacherState.initial() {
    return const OrderTeacherState(
      listData: null,
      detailData: null,
      present: null,
      presentPac: null,
      message: "",
      statePending: ReqOdrTeacPen.empty,
      stateSuccess: ReqOdrTeacSuc.empty,
      stateDetail: ReqOdrTeacDetail.empty,
      stateCancel: ReqOdrTeacCan.empty,
      stateDone: ReqOdrTeacDone.empty,
      statePresent: ReqPresent.empty,
      tidak: ReqTidak.empty,
      pac: ReqPresentPac.empty,
    );
  }

  @override
  List<Object?> get props => [
        listData,
        detailData,
        present,
        presentPac,
        message,
        statePending,
        stateSuccess,
        stateDetail,
        stateCancel,
        stateDone,
        statePresent,
        tidak,
        pac,
      ];
}
// abstract class OrderTeacherState extends Equatable {}

// class OrderLoading extends OrderTeacherState {
//   @override
//   List<Object?> get props => [];
// }

// class OrderError extends OrderTeacherState {
//   final String message;

//   OrderError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class OrderHasData extends OrderTeacherState {
//   final List<DataHistoryOrder> result;

//   OrderHasData(this.result);

//   @override
//   List<Object?> get props => [result];
// }

// class DetailHasData extends OrderTeacherState {
//   final DetailHistoryOrder result;

//   DetailHasData(this.result);

//   @override
//   List<Object> get props => [result];
// }


// class OrderEmpty extends OrderTeacherState {
//   @override
//   List<Object?> get props => [];
// }
