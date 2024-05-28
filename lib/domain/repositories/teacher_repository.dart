import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/bookmark_teacher_respone.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';

abstract class TeacherRepository {
  Future<Either<Failure, List<Teacher>>> getAllTeacher();
  Future<Either<Failure, List<Teacher>>> getTeacherMath();
  Future<Either<Failure, List<Teacher>>> getTeacherEnglish();
  Future<Either<Failure, List<Teacher>>> getTeacherIndonesian();
  Future<Either<Failure, List<Teacher>>> getTeacherBilogy();
  Future<Either<Failure, TeacherDetail>> getTeacherDetail(int id);
  Future<Either<Failure, List<Teacher>>> getSearchTeacher(String query);
  Future<Either<Failure, BookmarkTeacherResponse>> addTeacherToBookmark(int idStudent, int idTeacher, String token);
  Future<Either<Failure, String>> saveBookmarkTeacher(TeacherDetail teacher);
  Future<Either<Failure, String>> removeBookmarkTeacher(TeacherDetail teacher);
  Future<bool> issAddedToBookmark(int id);
  Future<Either<Failure, List<Teacher>>> getBookmarkList();
}