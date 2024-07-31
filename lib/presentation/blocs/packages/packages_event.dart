// ignore_for_file: prefer_const_constructors_in_immutables

part of 'packages_bloc.dart';

sealed class PackagesEvent extends Equatable {
  const PackagesEvent();

  @override
  List<Object> get props => [];
}

final class GetListPackagesEvent extends PackagesEvent {
  final int teacherId;

  const GetListPackagesEvent(this.teacherId);

  @override
  List<Object> get props => [];
}

class OnDetailPackagesEvent extends PackagesEvent {
  final int id;

  OnDetailPackagesEvent(this.id);

  @override
  List<Object> get props => [];
}

class OnAddDataPackages extends PackagesEvent {
  final int duration;
  final String name;
  final int price;
  final String desc;
  final List<String> day;
  final List<String> time;
  final int teacherId;

  const OnAddDataPackages({
    required this.duration,
    required this.name,
    required this.price,
    required this.desc,
    required this.day,
    required this.time,
    required this.teacherId,
  });
}


class OnUpdateDataPackages extends PackagesEvent {
  final int id;
  final int duration;
  final String name;
  final int price;
  final String desc;
  final List<String> day;
  final List<String> time;

  const OnUpdateDataPackages({
    required this.id,
    required this.duration,
    required this.name,
    required this.price,
    required this.desc,
    required this.day,
    required this.time,
  });
}

final class GetListMyPackagesEvent extends PackagesEvent {
  const GetListMyPackagesEvent();

  @override
  List<Object> get props => [];
}
