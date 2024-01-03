

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/working_with_firebase/model/response.dart';

final FirebaseFirestore _firestore=FirebaseFirestore.instance;
final CollectionReference _Collection=_firestore.collection('Employee');

class FirebaseCrud{

  //create
  static Future<Response> addEmployee({
    required String name,
    required String position,
    required String contactno,
 })async{
    Response response=Response();
    DocumentReference documentReference=_Collection.doc();

    Map<String, dynamic> data=<String, dynamic>{
      "employee_name":name,
      "position":position,
      "contactno":contactno
    };
    var result=await documentReference.set(data).whenComplete((){
      response.code=200;
      response.message="Successfully added to the database";
    }).catchError((e){
      response.code=500;
      response.message=e;
    });
    return response;
  }

  //read
  static Stream<QuerySnapshot> readEmployee(){
    CollectionReference notesItemCollection=_Collection;
    return notesItemCollection.snapshots();
  }
  //update
  static Future<Response> updateEmployee({
    required String name,
    required String position,
    required String contactno,
    required String docId,
  })async{
    Response response=Response();
    DocumentReference documentReference=_Collection.doc(docId);

    Map<String,dynamic> data=<String,dynamic>{
      "employee_name":name,
      "position":position,
      "contactno":contactno
    };

    await documentReference.update(data).whenComplete(() {
      response.code=200;
      response.message="Sucessfully updated Employee";
    }).catchError((e){
      response.code=500;
      response.message=e;
    });
    return response;
  }

  //delete
  static Future<Response> deleteEmployee({
    required String docId,
  })async{
    Response response=Response();
    DocumentReference documentReference=_Collection.doc(docId);

    await documentReference.delete().whenComplete(() {
      response.code=200;
      response.message="Sucessfully deleted";
    }).catchError((e){
      response.code=500;
      response.message=e;
    });
    return response;
  }
}