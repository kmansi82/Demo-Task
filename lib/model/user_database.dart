import 'package:mydemo/model/user_model_class.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
class UserDatabase {
  Database? _database = null;

  Future openDb() async {
    _database = await openDatabase(join(await getDatabasesPath(), "sqliteExample.db"),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE person (id INTEGER PRIMARY KEY autoincrement, first_name TEXT, last_name TEXT, user_name TEXT, password TEXT,confirm_password TEXT)",
          );
        });
    return _database;
  }

  Future<int?> insertData(UserModelClass model) async {
    await openDb();
    int? a= await _database?.insert('user', model.toJson());
    return a;
  }

  Future<List<UserModelClass>> getDataList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.rawQuery('SELECT * FROM person');

    return List.generate(maps.length, (i) {
      return UserModelClass(
          id: maps[i]['id'],
          firstName: maps[i]['firstName'],
          lastName: maps[i]['lastName'],
          userName: maps[i]['userName'],
          email: maps[i]['email'],
          password: maps[i]['password'],
          confirmPassword: maps[i]['confirmPassword']);

    });
  }

  // Future<int> updateData(UserModelClass model) async {
  //   await openDb();
  //   return await _database!.update('person', model.toJson(),
  //       where: "firstName = ?", whereArgs: [model.firstName]);
  // }
  //
  // Future<void> deleteData(UserModelClass model) async {
  //   await openDb();
  //   await _database!.delete('person', where: "id = ?", whereArgs: [model.id]);
  // }
}