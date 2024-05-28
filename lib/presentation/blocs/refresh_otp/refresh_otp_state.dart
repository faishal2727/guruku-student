part of 'refresh_otp_bloc.dart';

class RefreshOtpState extends Equatable {
  final RefreshOtpResponse? refreshOtpData;
  final String message;
  final RequestStateRefreshOtp stateRefresh;

  const RefreshOtpState({
    required this.refreshOtpData,
    required this.message,
    required this.stateRefresh,
  });

  RefreshOtpState copyWith({
    RefreshOtpResponse? refreshOtpData,
    String? message,
    RequestStateRefreshOtp? stateRefresh,
  }) {
    return RefreshOtpState(
      refreshOtpData: refreshOtpData ?? this.refreshOtpData,
      message: message ?? this.message,
      stateRefresh: stateRefresh ?? this.stateRefresh,
    );
  }

  factory RefreshOtpState.initial() {
    return const RefreshOtpState(
      refreshOtpData: null,
      message: " ",
      stateRefresh: RequestStateRefreshOtp.initial,
    );
  }

  @override
  List<Object?> get props => [
        refreshOtpData,
        message,
        stateRefresh,
      ];
}
