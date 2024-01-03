import 'package:email_validator/email_validator.dart';
import 'package:fb_series/task/firebase_firestore/model/model.dart';
import 'package:fb_series/task/firebase_firestore/screens/another%20ui/tabbarpage.dart';
import 'package:fb_series/task/firebase_firestore/services/databaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../data_showing.dart';

class FormRegister extends StatefulWidget {
   FormRegister({super.key,this.email,this.name,this.pass,this.dob,this.isEditing,this.title,this.id});

   String? id;
   String? title;
   String? email;
   String? pass;
   String? dob;
   String? name;
  bool? isEditing=false;
  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {

  final formkey = GlobalKey<FormState>();

  /// controller for the textformfield
  final emailcontroller=TextEditingController();
  final namecontroller=TextEditingController();
  final dobcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();

  /// Registration Page instance
  FormRegister? formRegisterupdate;

  @override
  void initState(){
    super.initState();
    formRegisterupdate = formRegisterdata;
    if( formRegisterupdate!=null && formRegisterupdate!.isEditing==true){
      namecontroller.text=formRegisterupdate!.name.toString();
      dobcontroller.text=formRegisterupdate!.dob.toString();
      emailcontroller.text=formRegisterupdate!.email.toString();
      passwordcontroller.text=formRegisterupdate!.pass.toString();
    }
  }

  final auth=FirebaseAuth.instance;
  ///firebase authentications of email and password
    Future<void> addEmailAndPass({required String email,required String password})async{
      await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    }

    void clearText(){
      namecontroller.clear();
      emailcontroller.clear();
      passwordcontroller.clear();
      dobcontroller.clear();
    }

  /// chcek the date ( validation )
  double isAdult(String enteredAge) {
    var birthDate = DateFormat('dd/MM/yyyy').parse(enteredAge);
    print("set state: $birthDate");
    var today = DateTime.now();
    final difference = today.difference(birthDate).inDays;
    print(difference);
    final year = difference / 365;
    print(year);
    return year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50,left: 15,right: 15),
          child: Container(
            height: 500,
            decoration: BoxDecoration(color: Colors.deepPurple.shade100),
            padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child:
                            /// Title Text
                        Text(formRegisterupdate!.isEditing==true?'${formRegisterupdate!.title}':'Registration',
                          style: TextStyle(fontSize: 26,color: Colors.deepPurple.shade700,fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                  /// User name TextFormField
                  TextFormField(
                    controller: namecontroller,
                    style: TextStyle(fontSize: 20,),
                    decoration: InputDecoration(hintText: 'Name',prefixIcon: Icon(Icons.person)),
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'This Field is required';
                      }
                      return null;
                    },
                  ),

                  /// Email TextField
                  TextFormField(
                    controller:emailcontroller,
                    style: TextStyle(fontSize: 20,),
                    decoration: InputDecoration(hintText: 'Email',prefixIcon: Icon(Icons.email)),
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'This Field is required';
                      }else if(EmailValidator.validate(value.toString())){
                        return null;
                      }else{
                        return 'Enter proper email like name@gmail.com';
                      }
                    }
                  ),

                  /// Date TextFormField
                  TextFormField(
                    controller:dobcontroller,
                    style: TextStyle(fontSize: 20,),
                    readOnly: true,
                    decoration: InputDecoration(hintText: 'DOB',prefixIcon: Icon(Icons.date_range_rounded)),
                    onTap: ()async {
                      DateTime? date = await showDatePicker(context: context,
                          firstDate:DateTime(1999),
                          lastDate: DateTime.now());
                          var formate = DateFormat("dd/MM/yyyy").format(date!);
                          dobcontroller.text = formate.toString();
                    },
                    validator: (value) {

                      if(value==null || value.isEmpty){
                        return 'This Field is required';
                      }else if(isAdult(value)<18){
                        return 'Age must be 18';
                      }
                      return null;
                    },
                  ),

                  /// Password TextFormField
                  TextFormField(
                    controller:passwordcontroller,
                    style: TextStyle(fontSize: 20,),
                    decoration: InputDecoration(hintText: 'Password',prefixIcon: Icon(Icons.lock_outline)),
                    validator: (PassCurrentValue) {
                      RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      var passNonNullValue=PassCurrentValue??"";
                      if(passNonNullValue.isEmpty){
                        return ("Password is required");
                      }
                      else if(passNonNullValue.length<6){
                        return ("Password Must be more than 6 characters");
                      }
                      else if(!regex.hasMatch(passNonNullValue)){
                        return ("Password should contain upper,lower,digit and Special\n character ");
                      }
                      return null;
                    },
                  ),

                  /// Button
                  Padding(padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: ()async{
                        if(formRegisterupdate!.isEditing==true){
                          if(formkey.currentState!.validate()){
                            await FirebaseService.editData(
                                id: formRegisterupdate!.id.toString(),
                                name: namecontroller.text,
                                email: emailcontroller.text,
                                dob: dobcontroller.text,
                                password: passwordcontroller.text
                            );
                            setState(() {
                              clearText();
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Updated Successfully')),
                            );
                            formRegisterupdate!.title='Register';
                            formRegisterupdate!.isEditing=false;
                            clearText();
                          }}else {
                            if (formkey.currentState!.validate()) {
                              addEmailAndPass(email: emailcontroller.text,
                                  password: passwordcontroller.text);
                              await FirebaseService.addData(
                                  DataModel(
                                      id: Uuid().v4(),
                                      name: namecontroller.text,
                                      email: emailcontroller.text,
                                      dob: dobcontroller.text,
                                      password: passwordcontroller.text
                                  )
                              );
                              setState(() {

                              });
                              clearText();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Registered Successfully')),
                              );
                            }
                          }
                        clearText();
                        },
                      child: Container(
                        height: 50,
                      width: 150,
                      decoration: BoxDecoration(color: Colors.deepPurple.shade400),
                      child: Center(child: Text(formRegisterupdate!.isEditing==true?'${formRegisterupdate!.title}':'Register',style: TextStyle(color: Colors.white,fontSize: 18),),),
                      ),
                    ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
