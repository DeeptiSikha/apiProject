import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

import 'package:untitled1/resturant_prj/food_item_model.dart';

class DataBaseHelper{
  static final DataBaseHelper _dataBaseHelper=DataBaseHelper._internal();
  DataBaseHelper._internal();
  factory DataBaseHelper()=>_dataBaseHelper;
  Database? _database;

  Future<Database> get database async{
    if(_database!=null)return _database!;
    _database=await initDatabase();
    return _database!;
  }
  Future<Database> initDatabase() async {
    final getdirectorypath= await getApplicationDocumentsDirectory();
    String path=getdirectorypath.path+'food.db';
      return openDatabase(path,version: 1,onCreate: _onCreate);
  }
  void _onCreate(Database db,int version) async{
    await db.execute(
      'CREATE TABLE tblfood(id TEXT PRIMARY KEY,foodname TEXT,description TEXT,price INTEGER)'
    );
  }
  //insert code of database
  Future<void> insertFood(FoodItemModel model) async{
    final db=await _dataBaseHelper.database;
    var insert=await db.rawInsert(
      'INSERT INTO tblfood (id,foodname,description,price)VALUES(?,?,?,?)',
      [model.id,model.foodname,model.description,model.price]
    );
    log('$insert');
  }
  //delete code
  Future<void> deleteFood(String id) async{
    final db=await _dataBaseHelper.database;
    var delete=await db.rawDelete(
      'DELETE FROM tblfood WHERE id=?',[id]
    );
    log('$delete');
  }
  //edit code
  Future<void> editFood(FoodItemModel model) async{
    final db=await _dataBaseHelper.database;
    var update=await db.rawUpdate(
      'UPDATE tblfood SET foodname=?,description=?,price=? WHERE id=?',
      [model.foodname,model.description,model.price,model.id]
    );
    log('$update');
  }
  //get all recorde
  Future<List<FoodItemModel>> getalldata()async{
    final db=await _dataBaseHelper.database;
    var get=await db.rawQuery(
      'SELECT * FROM tblfood'
    );
    List<FoodItemModel> food=List.generate(
        get.length,
        (index) => FoodItemModel.fromJson(get[index])
    );
    print(food.length);
    return food;
  }
}