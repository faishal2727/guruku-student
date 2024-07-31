part of 'withdraw_bloc.dart';

class WithdrawState extends Equatable {
  final WithdrawResponse? wdData;
  final List<WithdrawDetailResponse>? dataList;
  final WithdrawDetailResponse? dataDetail;
  final String message;
  final RequestStateWd stateWd;
  final ReqStateListWd stateListWd;
  final ReqStateListWdStudent stateListWdStudent;
  final ReqStateWdDetail stateWdDetail;

  const WithdrawState({
    required this.wdData,
    required this.dataList,
    required this.dataDetail,
    required this.message,
    required this.stateWd,
    required this.stateListWd,
    required this.stateListWdStudent,
    required this.stateWdDetail,
  });

  WithdrawState copyWith({
    WithdrawResponse? wdData,
    List<WithdrawDetailResponse>? dataList,
    WithdrawDetailResponse? dataDetail,
    String? message,
    RequestStateWd? stateWd,
    ReqStateListWd? stateListWd,
    ReqStateListWdStudent? stateListWdStudent,
    ReqStateWdDetail? stateWdDetail,
  }) {
    return WithdrawState(
      wdData: wdData ?? this.wdData,
      dataList: dataList ?? this.dataList,
      dataDetail: dataDetail ?? this.dataDetail,
      message: message ?? this.message,
      stateWd: stateWd ?? this.stateWd,
      stateListWd: stateListWd ?? this.stateListWd,
      stateListWdStudent: stateListWdStudent?? this.stateListWdStudent,
      stateWdDetail: stateWdDetail ?? this.stateWdDetail,
    );
  }

  factory WithdrawState.initial() {
    return const WithdrawState(
      wdData: null,
      dataList: null,
      dataDetail: null,
      message: " ",
      stateWd: RequestStateWd.initial,
      stateListWd: ReqStateListWd.initial, 
      stateListWdStudent: ReqStateListWdStudent.initial,
      stateWdDetail: ReqStateWdDetail.initial,
    );
  }

  @override
  List<Object?> get props => [
        wdData,
        dataList,
        dataDetail,
        message,
        stateWd,
        stateListWd,
        stateListWdStudent,
        stateWdDetail,
      ];
}
