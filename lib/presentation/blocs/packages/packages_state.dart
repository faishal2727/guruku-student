part of 'packages_bloc.dart';

class PackagesState extends Equatable {
  final List<Packages>? packages;
  final Packages? detail;
  final PackagesResponse? add;
  final PackagesResponse? update;
  final RequestStatePackages state;
  final RequestStateAddPackages addState;
  final RequestStateUpdatePackages updateState;
  final RequestStatePackagesDetail stateDetail;
  final String message;

  const PackagesState({
    this.packages,
    required this.detail,
    required this.add,
    required this.update,
    required this.state,
    required this.addState,
    required this.updateState,
    required this.stateDetail,
    required this.message,
  });

  @override
  List<Object?> get props => [
        packages,
          detail,
        add,
        update,
      
        state,
        addState,
        updateState,
        stateDetail,
        message,
      ];

  PackagesState copyWith({
    List<Packages>? packages,
    PackagesResponse? add,
     PackagesResponse? update,
    
    Packages? detail,
    RequestStatePackages? state,
    RequestStateAddPackages? addState,
    RequestStateUpdatePackages? updateState,
    RequestStatePackagesDetail? stateDetail,
    String? message,
  }) {
    return PackagesState(
      packages: packages ?? this.packages,
      add: add ?? this.add,
      update: update ?? this.update,
      detail: detail ?? this.detail,
      state: state ?? this.state,
      addState: addState ?? this.addState,
      updateState: updateState ?? this.updateState,
      stateDetail: stateDetail ?? this.stateDetail,
      message: message ?? this.message,
    );
  }

  factory PackagesState.initial() {
    return const PackagesState(
      packages: null,
      add: null,
      update: null,
      detail: null,
      state: RequestStatePackages.empty,
      addState: RequestStateAddPackages.initial,
      updateState: RequestStateUpdatePackages.initial,
      stateDetail: RequestStatePackagesDetail.initial,
      message: '',
    );
  }
}
