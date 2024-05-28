import 'package:guruku_student/domain/repositories/teacher_repository.dart';

class GetBookmarkStatus {
  final TeacherRepository repository;

  GetBookmarkStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.issAddedToBookmark(id);
  }
}