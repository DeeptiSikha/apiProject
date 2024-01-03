
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_series/firebase_practice/practice/model.dart';

final FirebaseFirestore firestore=FirebaseFirestore.instance;
final CollectionReference reference=firestore.collection('Information');

class DatabaseService{

   static Future<void> add(Data data) async {
     await reference.add(
       Data(id: data.id,name: data.name,age: data.age)
       );
   }


}