import 'package:firebase_database/firebase_database.dart';
import 'package:untitled1/working_with_firebase/firebase%20service/service.dart';

class DataService{
  final DatabaseReference _dbRef=FirebaseService().databaseRef.child('items');

   Future<void> createItem(String name,String desc)async{
    final newItemRef=_dbRef.push();
    await newItemRef.set({
      'name':name,
      'description':desc,
    });
  }

  Future<DatabaseEvent> readItems()async{
    return await _dbRef.once();
  }

  Future<void> updateItem(String itemId,String newName,String newDesc) async{
    final itemRef=_dbRef.child(itemId);
    await itemRef.update({
      'name':newName,
      'description':newDesc,
    });
  }

  Future<void> deleteItem(String itemId)async{
    final itemRef=_dbRef.child(itemId);
    await itemRef.remove();
  }
}