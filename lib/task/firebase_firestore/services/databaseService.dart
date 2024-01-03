
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_series/task/firebase_firestore/model/model.dart';

final FirebaseFirestore db=FirebaseFirestore.instance;
final CollectionReference _Collection=db.collection('User_Data');

class FirebaseService{

  /// method for adding data to database
  static Future<void> addData(DataModel model)async{
    DocumentReference doc=_Collection.doc();
    final data=DataModel(
        id:model.id,name: model.name, email: model.email, password: model.password, dob: model.dob);
    await doc.set(data.toJson());
  }

  // static Future<void> addUser({required String name,required String email,required String password,required String dob})async{
  //   DocumentReference doc=_Collection.doc();
  //   Map<String,dynamic> data={
  //     'name':name,
  //     'email':email,
  //     'password':password,
  //     'dob':dob
  //   };
  //   await doc.set(data);
  // }

  /// method for getting data from database
  static Stream<QuerySnapshot> getData(){
    CollectionReference col =_Collection;
    return col.snapshots();
  }


  // Future<String?> getUser(String email) async {
  //   try {
  //     CollectionReference users = FirebaseFirestore.instance.collection('users');
  //     final snapshot = await users.doc(email).get();
  //     final data = snapshot.data() as Map<String, dynamic>;
  //     return data['name'];
  //   } catch (e) {
  //     return 'Error fetching user';
  //   }
  // }

  /// method for editing data
  static Future<void> editData({required String id,required String name,required String email,required String dob,required String password})async{
    DocumentReference doc=_Collection.doc(id);
    Map<String,dynamic> data={
      'name':name,
      'email':email,
      'dob':dob,
      'password':password
    };
    await doc.update(data);
  }

  /// method for deleting data
  static Future<void> deleteData({required String id})async{
    DocumentReference doc=_Collection.doc(id);
    await doc.delete();
  }


}