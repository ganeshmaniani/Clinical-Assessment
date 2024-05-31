import 'package:sqflite/sqflite.dart';

import '../core.dart';

class NetWorkDataBaseService extends BaseCRUDDataBaseServices {
  late DataBaseService _dataBaseServices;

  NetWorkDataBaseService() {
    _dataBaseServices = DataBaseService();
  }

  static Database? _database;

  @override
  // TODO: implement database
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _dataBaseServices.setDataBase();
      return _database;
    }
  }

  @override
  Future insertData(String tableName, Map<String, dynamic> data) async {
    var connection = await database;
    return await connection?.insert(tableName, data);
  }

  @override
  Future getData(tableName) async {
    var connection = await database;
    return await connection?.query(tableName,
        orderBy: "${DBKeys.dbColumnId} DESC");
  }

  @override
  Future getDataById(tableName, itemId,columName) async {
    var connection = await database;
    return await connection?.query(
      tableName,
      where: '$columName=?',
      whereArgs: [itemId],
    );
  }

  @override
  Future updateDataById(
      String tableName, Map<String, dynamic> data, int itemId) async {
    var connection = await database;
    return await connection!.update(tableName, data,
        where: '${DBKeys.dbColumnId} = ?', whereArgs: [itemId]);
  }

  @override
  Future deleteDataById(tableName, itemId) async {
    var connection = await database;
    return connection?.rawDelete('delete from $tableName where id=$itemId');
  }

  @override
  Future getUserById(tableName, itemId) async {
    var connection = await database;
    return connection?.query(tableName, where: 'id=?', whereArgs: [itemId]);
  }

  @override
  Future deleteAllData(tableName) async {
    var connection = await database;
    return connection!.delete(tableName);
  }
}
