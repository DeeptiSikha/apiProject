import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/firebase%20authentication/firebase%20email%20password/screen/homepage.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();

  final FirebaseAuth auth=FirebaseAuth.instance;

  //signIn method
  void _signInWithEmailAndPassword() async {
    await auth.signInWithEmailAndPassword(
      email: emailcontroller.text,
      password: passwordcontroller.text,
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign In',style: TextStyle(fontSize: 26,color: Colors.grey.shade700,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Container(
                child: Column(
                  children: [
                    TextField(
                      controller:emailcontroller,
                      decoration: InputDecoration(hintText: 'Enter email'),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller:passwordcontroller,
                      decoration: InputDecoration(hintText: 'Enter password'),
                    ),
                    SizedBox(height: 30,),
                    Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                              _signInWithEmailAndPassword();
                          },
                          child: const Text('Sign In'),
                        ),
                      ),
                    SizedBox(height: 20,),
                    Text("Continue With"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
