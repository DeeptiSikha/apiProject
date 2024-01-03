import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/another%20sqlite_store_studinfo/login.dart';
import 'package:untitled1/another%20sqlite_store_studinfo/model_signUp.dart';
import 'package:untitled1/another%20sqlite_store_studinfo/signUp_database.dart';

class SignUpStudInfo extends StatefulWidget {
  const SignUpStudInfo({super.key});

  @override
  State<SignUpStudInfo> createState() => _SignUpStudInfoState();
}

class _SignUpStudInfoState extends State<SignUpStudInfo> {

  final emailecontroller=TextEditingController();
  final phonecontroller=TextEditingController();
  final passcontroller=TextEditingController();
  final repasscontroller=TextEditingController();
  late DatabaseSignUp databaseSignUp;

  void addData(){
    SignUpDataModel(email: emailecontroller.text, pass: passcontroller.text, id:Uuid().v4());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 600,
          width: 400,
          color: Colors.grey.shade100,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign Up',style: TextStyle(fontSize: 26),),
              SizedBox(height: 20,),
              TextField(
                controller: emailecontroller,
                decoration: InputDecoration(hintText: 'Enter Email'),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: phonecontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter Phone'),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: passcontroller,
                decoration: InputDecoration(hintText: 'Create Password'),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: repasscontroller,
                decoration: InputDecoration(hintText: 'Renter Password'),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(child: Text('Sign Up',
                    style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                ),
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',style: TextStyle(fontSize: 18,)),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginStudInfo(),));
                  }, child: Text('LogIn',style: TextStyle(fontSize: 18,)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
