import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fb_series/task/firebase_firestore/screens/another%20ui/tabbarpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});
  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {

  final formkey = GlobalKey<FormState>();

  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();

  final auth=FirebaseAuth.instance;

  Future<void> loginEmailAndPassword({required String email,required String password})async{
    await  auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
        child: Container(
          height: 300,
          padding: const EdgeInsets.only(top: 40,left: 15,right: 15),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100
          ),
          child: Form(
            key: formkey,
            child: Column(
              children: [
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
                /// Password TextField
                TextFormField(
                  controller:passwordcontroller,
                  style: TextStyle(fontSize: 20,),
                  decoration: InputDecoration(hintText: 'Password',prefixIcon: Icon(Icons.lock_outline)),
                ),
                /// Button
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: ()async{
                     await FirebaseFirestore.instance
                          .collection('User_Data')
                          .get()
                          .then((QuerySnapshot querySnapshot) {
                        querySnapshot.docs.forEach((doc) {
                          // if(doc['email']==emailcontroller.text ){
                          //   if(doc['password']==passwordcontroller.text) {
                          //     if (formkey.currentState!.validate()) {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         const SnackBar(
                          //             content: Text('Login Successfully')),
                          //       );
                          //     }
                          //   }else{
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         const SnackBar(content: Text('Wrong Email'))
                          //     );}
                          // }else{
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(content: Text('Wrong Email'))
                          //   );}

                          // if(doc['email']==emailcontroller.text && doc['password']==passwordcontroller.text){
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //                 const SnackBar(
                          //                     content: Text('Login Successfully')),
                          //     );
                          //   }else{
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //               const SnackBar(content: Text('Wrong Password or Email'))
                          //     );
                          //   }
                          loginEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);
                          tabController!.index=1;
                          }
                        );
                      });
                  },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(color: Colors.deepPurple.shade400),
                      child: Center(child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 18),),),
                    ),
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
