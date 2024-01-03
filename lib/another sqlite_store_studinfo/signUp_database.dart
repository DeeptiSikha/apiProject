import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/another%20sqlite_store_studinfo/model_signUp.dart';

class DatabaseSignUp{
  static final DatabaseSignUp databaseSignUp=DatabaseSignUp._internal();
  DatabaseSignUp._internal();
  Database? _database;
  factory DatabaseSignUp()=> databaseSignUp;

  Future<Database> get database async{
    if(_database!=null)return _database!;
     _database=await initDB();
     return _database!;
  }
  Future<Database> initDB() async{
    final getpath=await getApplicationDocumentsDirectory();
    String path=getpath.path+'/signup.db';
    return await openDatabase(path,version: 1,onCreate: _onCreate);
  }
  void _onCreate(Database db,int version) async{
    await db.execute(
      'CREATE TABLE tblsignup (id TEXT PRIMARY KEY,email TEXT,pass TEXT)'
    );
  }

  Future<List<SignUpDataModel>> getallData()async{
    final db=await databaseSignUp.database;
    var get=await db.rawQuery('SELECT * FROM tblsignup');
    List<SignUpDataModel> list=List.generate(get.length, (index) => SignUpDataModel.fromJson(get[index]));
    return list;
  }

  Future<void> insertData(SignUpDataModel model)async{
    final db=await databaseSignUp.database;
    await db.rawInsert(
      'INSERT INTO tblsignup (id,email,pass)VALUES(?,?,?,?)',
      [model.id,model.email,model.pass]
    );
  }

  Future<void> updateData(SignUpDataModel model)async{
    final db=await databaseSignUp.database;
    await db.rawUpdate(
        'UPDATE tblsignup SET email=?,pass=? WHERE id=?',
        [model.email,model.pass,model.id]
    );
  }

  Future<void> deleteData(String id)async{
    final db=await databaseSignUp.database;
    await db.rawDelete(
        'DELETE FROM tblsignup WHERE id=?',
        [id]
    );
  }
}