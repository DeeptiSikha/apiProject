import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase authentication/firebase email password/screen/signIn_page.dart';
import 'firebase authentication/firebase email password/screen/signup.dart';
import 'firebase firestore/ui_for_crud.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyCLWqVmTYgBDorKcTJGlR_zGGN4-PBAz1E',
        appId: '1:581712132493:android:b8d9d1e93c571594f7e5c4',
        messagingSenderId: '581712132493',
        projectId:
        'fir-work-303c3')
  );
  // final FirebaseFirestore firestore=FirebaseFirestore.instance;
  // final CollectionReference reference=firestore.collection("users");

  // //read the data
  // final DocumentSnapshot snapshot=await reference.doc("zTNsXOSEPnUO18d6J5sH").get();
  // final userfield=snapshot.data();
  // print('the data-->'+userfield.toString());

  // //add data
  // final Map<String, dynamic> userField={
  //   'email':'newUser@gmail.com'
  // };
  // await reference.doc("newUser").set(userField);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SignUp()
    );
  }
}

