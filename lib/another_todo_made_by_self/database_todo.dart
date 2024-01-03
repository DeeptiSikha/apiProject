import 'dart:developer';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/another_todo_made_by_self/todo_model.dart';

class DataBaseService{
  static final DataBaseService _dataBaseService=DataBaseService._internal();

  DataBaseService._internal();

  factory DataBaseService()=>_dataBaseService;

  static Database? _database;

  //checking database has or not
  Future<Database> get database async{
    if(_database!=null) return _database!;
    _database=await initDatabase();
    return _database!;
  }

  //creating database table and getting the path
  Future<Database> initDatabase() async{
    final getdirectory=await getApplicationDocumentsDirectory();
    String path=getdirectory.path + '/todo.db';
    log(path);
    return openDatabase(path,onCreate: _onCreate,version: 1);
  }
  void _onCreate(Database db,int version)async{
    await db.execute(
      'CREATE TABLE todo(id TEXT PRIMARY KEY,title TEXT,subtitle TEXT)'
    );
    log('table created');
  }

  // insert code
  Future<void> insertTodo(TodoModel model)async{
    final db=await _dataBaseService.database;
    var todo = await db.rawInsert(
      'INSERT INTO todo(id,title,subtitle)VALUES(?,?,?)',
        [model.id,model.title,model.subtitle]
    );
    log('$todo');
  }

  //delete
  Future<void> deleteTodo(String id) async{
    final db= await _dataBaseService.database;
    var todo=await db.rawDelete(
      'DELETE FROM todo WHERE id=?',[id]
    );
    log('$todo');
  }
  // edit
  Future<void> edittodo(TodoModel model) async{
    final db=await _dataBaseService.database;
    var todo=await db.rawUpdate(
      'UPDATE todo SET title=?,subtitle=? WHERE id=?',
      [model.title,model.subtitle,model.id]
    );
    log('$todo');
  }

  //get all data
  Future<List<TodoModel>> getTodo()async{
    final db=await _dataBaseService.database;
    var todo=await db.rawQuery('SELECT * FROM todo');
    List<TodoModel> movies=List.generate(todo.length, (index) => TodoModel.fromJson(todo[index]));
    print(movies.length);
    return movies;
  }
}