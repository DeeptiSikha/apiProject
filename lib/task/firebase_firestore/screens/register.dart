//register screen
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../model/model.dart';
import '../services/databaseService.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen({super.key});


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  final dobcontroller=TextEditingController();
  final namecontroller=TextEditingController();

  bool _obsercureText=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
        child: SingleChildScrollView(
          child:Container(
            height: 460,
            width: 400,
            color: Colors.deepPurple.shade200,
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.only(left: 10,right: 10,top: 30),
                  child: Center(child: Text('Register',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),),
                ),
                Padding(padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: TextField(
                    controller: namecontroller,
                    style: TextStyle(fontSize: 20,color: Colors.deepPurple,fontWeight: FontWeight.bold),
                    decoration: InputDecoration(prefixIcon: Icon(Icons.person_2),hintText: 'User Name'),

                  ),
                ),
                Padding(padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: TextField(
                    controller: emailcontroller,
                    style: TextStyle(fontSize: 20,color: Colors.deepPurple,fontWeight: FontWeight.bold),
                    decoration: InputDecoration(prefixIcon: Icon(Icons.email),hintText: 'Email'),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: TextField(
                    controller: dobcontroller,
                    readOnly: true,
                    keyboardType: TextInputType.emailAddress,
                    onTap: ()async{
                      DateTime? date=await showDatePicker(context: context, firstDate: DateTime(1980), lastDate: DateTime.now());
                      var formate=DateFormat("dd/MM/yyyy").format(date!);
                      dobcontroller.text=formate.toString();
                      setState(() {

                      });
                    },
                    style: TextStyle(fontSize: 20,color: Colors.deepPurple,fontWeight: FontWeight.bold),
                    decoration: InputDecoration(prefixIcon: Icon(Icons.date_range),hintText: 'Date Of Birth'),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                  child: TextField(
                    controller: passwordcontroller,
                    obscureText: _obsercureText,
                    style: TextStyle(fontSize: 20,color: Colors.deepPurple,fontWeight: FontWeight.bold),
                    decoration: InputDecoration(prefixIcon: Icon(Icons.password),hintText: 'Password',
                        suffixIcon:IconButton(
                          onPressed: (){
                            setState(() {
                              if(_obsercureText){
                                _obsercureText=false;
                              }else{
                                _obsercureText=true;
                              }
                            });
                        },
                        icon: Icon(_obsercureText==true?Icons.remove_red_eye:Icons.password),) ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 40),
                  child: GestureDetector(
                    onTap: ()async{
                      if (emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty && dobcontroller.text.isNotEmpty && namecontroller.text.isNotEmpty ) {
                        if(EmailValidator.validate(emailcontroller.text)){
                        await FirebaseService.addData(
                            DataModel(
                                name: namecontroller.text,
                                email: emailcontroller.text,
                                password: passwordcontroller.text,
                                dob: dobcontroller.text
                            )
                        );
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Successful"),
                            content: const Text("Record Added Successfully"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  color: Colors.deepPurple.shade500,
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("okay",style:TextStyle(color: Colors.white),),
                                ),
                              ),
                            ],
                          ),
                        );
                        setState(() { });
                        namecontroller.clear();
                        emailcontroller.clear();
                        dobcontroller.clear();
                        passwordcontroller.clear();
                        Get.back();
                        }else{
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Alert"),
                              content: const Text("Email is not Valid"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    color: Colors.deepPurple.shade500,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("okay",style:TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      } else if (namecontroller.text.isEmpty || passwordcontroller.text.isEmpty ||
                          emailcontroller.text.isEmpty || dobcontroller.text.isEmpty){
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Alert"),
                            content: const Text("All Field Are Mandatory!"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  color: Colors.deepPurple.shade500,
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("okay",style:TextStyle(color: Colors.white),),
                                ),
                              ),
                            ],
                          ),
                        );
                    }},
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade400,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight:Radius.circular(20)),
                      ),
                      child: Center(child: Text('Register',style: TextStyle(fontSize: 20,color: Colors.white),)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}