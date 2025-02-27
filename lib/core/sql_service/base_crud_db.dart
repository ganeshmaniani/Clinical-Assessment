import 'package:sqflite/sqflite.dart';

abstract class BaseCRUDDataBaseServices {
  // Initiate Data Base
  Future<Database?> get database;

  // Insert the Data into the Table
  Future<dynamic> insertData(String tableName, Map<String, dynamic> data);

//Get the data in table
  Future<dynamic> getData(tableName);

  // Get the data in table By ID
  Future<dynamic> getDataById(tableName, itemId, columName);

  // Update the data in table
  Future<dynamic> updateDataById(
      String tableName, Map<String, dynamic> data, int itemId);

  //  Dalete the data in table
  Future<dynamic> deleteDataById(tableName, itemId);

  Future<dynamic> getUserById(tableName, itemId);
  Future<dynamic> deleteAllData(tableName);
}
