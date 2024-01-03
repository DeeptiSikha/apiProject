import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore db=FirebaseFirestore.instance;
final CollectionReference reference = db.collection("UserInfo");

class FirebaseFirestoreService {

  static Future<void> addUser({required String name,required String phone,required String email}) async{
    DocumentReference documentReference = reference.doc();
    Map<String,dynamic> userData={
      'name':name,
      'phone':phone,
      'email':email
    };
    var result=await documentReference.set(userData);
  }

  static Stream<QuerySnapshot> readUser(){
      CollectionReference collection=reference;
      return collection.snapshots();
  }

  static Future<void> deleteUser({required String id}) async{
   DocumentReference documentReference=reference.doc(id);
   await documentReference.delete();
  }

  static Future<void> editUser({required String name,required String phone,required String email,required String id})async{
    DocumentReference documentReference=reference.doc(id);
    Map<String,dynamic> userData={
      'name':name,
      'phone':phone,
      'email':email
    };
    var result=await documentReference.update(userData);
  }
}