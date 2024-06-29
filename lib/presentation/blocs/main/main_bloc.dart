import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetAuth getAuth;

  MainBloc({
    required this.getAuth,
  }) : super(MainState.initial()) {
    on<DoIsLoginEvent>((event, emit) async {
      final result = await getAuth.execute();
      if (result != null) {
        emit(state.copyWith(isLogin: true, role: result.role));
      } else {
        emit(state.copyWith(isLogin: false));
      }
    });
    
  }
}


    // on<DoTabChangeEvent>((event, emit) {
    //   emit(state.copyWith(tabIndex: event.tabIndex));
    // });