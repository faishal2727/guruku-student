part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class OnReloadProfileEvent extends ProfileEvent {
  const OnReloadProfileEvent();
}


class OnProfileEvent extends ProfileEvent {}

class OnUpdateProfileEvent extends ProfileEvent {
  final String username;
  final String name;
  final String email;
  final String phone;
  final String education;
  final String address;
  final DateTime bod;
  final String lat;
  final String lon;

  const OnUpdateProfileEvent({
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.education,
    required this.address,
    required this.bod,
    required this.lat,
    required this.lon,
  });
  @override
  List<Object> get props => [
        username,
        name,
        email,
        phone,
        education,
        address,
        bod,
        lat,
        lon,
      ];
}

class OnUpdateAvatarEvent extends ProfileEvent {
  final List<int> bytes;
  final String fileName;

  const OnUpdateAvatarEvent({
    required this.bytes,
    required this.fileName,
  });

  @override
  List<Object> get props => [bytes, fileName];
}

