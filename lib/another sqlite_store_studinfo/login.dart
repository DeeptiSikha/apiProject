
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginStudInfo extends StatefulWidget {
  const LoginStudInfo({super.key});

  @override
  State<LoginStudInfo> createState() => _LoginStudInfoState();
}

class _LoginStudInfoState extends State<LoginStudInfo> {

  final namecontroller=TextEditingController();
  final agecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 400,
          width: 400,
          color: Colors.grey.shade100,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Log in',style: TextStyle(fontSize: 26),),
              SizedBox(height: 20,),
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(hintText: 'Enter name'),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: agecontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter age'),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  height: 50,
                  width: 200,
                  color: Colors.grey,
                  child: Center(child: Text('Log In',style: TextStyle(color: Colors.white,fontSize: 18),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
