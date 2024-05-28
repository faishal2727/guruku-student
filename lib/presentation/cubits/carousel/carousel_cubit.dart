import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'carousel_state.dart';
part 'carousel_cubit.freezed.dart';


class CarouselCubit extends Cubit<int> {
  CarouselCubit() : super(0);

  void onPageChanged(int index) => emit(index);
}