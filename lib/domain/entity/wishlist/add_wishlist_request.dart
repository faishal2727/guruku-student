import 'package:equatable/equatable.dart';

class AddWishlistRequest extends Equatable {
  final int idTeacher;

  const AddWishlistRequest({
    required this.idTeacher,
  });

  @override
  List<Object?> get props => [
        idTeacher,
      ];
}
