part of 'register_teacher_bloc.dart';

abstract class RegisterTeacherEvent extends Equatable {
  const RegisterTeacherEvent();

  @override
  List<Object> get props => [];
}

class DoRegisterTeacher extends RegisterTeacherEvent {
  final String username;
  final String email;
  final String phone;
  final String education;
  final String jurusan;
  final String tahunLulus;
  final String idCard;
  final String file;

  const DoRegisterTeacher({
    required this.username,
    required this.email,
    required this.phone,
    required this.education,
    required this.jurusan,
    required this.tahunLulus,
    required this.idCard,
    required this.file,
  });
}

class DoUploadCloudinary extends RegisterTeacherEvent {
  final List<int> bytes;
  final String fileName;

  const DoUploadCloudinary({
    required this.bytes,
    required this.fileName,
  });
}
