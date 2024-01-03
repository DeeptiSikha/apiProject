import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/another%20sqlite_store_studinfo/model_stud.dart';

class DatabaseHelper{
  static final DatabaseHelper databaseHelper= DatabaseHelper._internal();
  DatabaseHelper._internal();
  factory DatabaseHelper()=>databaseHelper;
   Database? _database;

  Future<Database> get database async{
    if(_database!=null)return _database!;
    _database=await initDB();
    return _database!;
  }

  Future<Database> initDB() async{
    final getdirectorypath=await getApplicationDocumentsDirectory();
    String path=getdirectorypath.path+'/studinfo';
    return await openDatabase(path,version: 1,onCreate: _onCreate);
  }

  void _onCreate(Database db,int version)async{
    await db.execute(
      'CREATE TABLE tblstud(id TEXT PRIMARY KEY,name TEXT,age TEXT,img TEXT)'
    );
  }

  Future<void> addData(StudInfo info)async{
    final db=await databaseHelper.database;
    await db.rawInsert(
      'INSERT INTO tblstud(id,name,age,img) VALUES(?,?,?,?)',
      [info.id,info.name,info.age,info.img]
    );
  }

  Future<void> deleteData(String id)async{
    final db=await databaseHelper.database;
    db.rawDelete('DELETE FROM tblstud WHERE id=?',
    [id]
    );
  }

  Future<void> updateData(StudInfo info)async{
    final db=await databaseHelper.database;
    db.rawUpdate(
      'UPDATE tblstud SET name=?,age=?,img=? WHERE id=?',
      [info.name,info.age,info.img,info.id]
    );
  }

  Future<List<StudInfo>> getAllData()async{
    final db=await databaseHelper.database;
    var data=await db.rawQuery(
      'SELECT * FROM tblstud'
    );
    List<StudInfo> list=List.generate(
        data.length,
            (index) => StudInfo.frmJson(data[index])
    );
    return list;
  }
}