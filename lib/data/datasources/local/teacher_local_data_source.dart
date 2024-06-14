import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/data/datasources/db/database_helper.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_table.dart';

abstract class TeacherLocalDataSource {
  Future<String> insertBookmark(TeacherTable teacher);
  Future<String> removeBookmark(TeacherTable teacherTable);
  Future<TeacherTable?> getBookmarkById(int id);
  Future<List<TeacherTable>> getBookmarkList();
}

class TeacherLocalDataSourceImpl implements TeacherLocalDataSource {
  final DatabaseHelper databaseHelper;

  TeacherLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertBookmark(TeacherTable teacher) async {
    try {
      await databaseHelper.insertBookmark(teacher);
      return 'Added to Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeBookmark(TeacherTable teacherTable) async {
    try {
      await databaseHelper.removeBookmark(teacherTable);
      return 'Removed from Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TeacherTable?> getBookmarkById(int id) async {
    final result = await databaseHelper.getBookmarkById(id);
    if (result != null) {
      return TeacherTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TeacherTable>> getBookmarkList() async {
    final result = await databaseHelper.getBookmarkList();
    return result.map((data) => TeacherTable.fromMap(data)).toList();
  }
}
