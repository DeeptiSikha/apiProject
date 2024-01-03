import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/firebase%20authentication/firebase%20email%20password/screen/homepage.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();

  final FirebaseAuth auth= FirebaseAuth.instance;

  void _signUp()async{
    await auth.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sign Up',style: TextStyle(fontSize: 26,color: Colors.grey.shade700,fontWeight: FontWeight.bold),),
          Container(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
            child: Column(
              children: [
                TextField(
                  controller:emailcontroller,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.email),hintText: 'Email'),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller:passwordcontroller,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.password),hintText: 'Create Password'),
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
                      _signUp();
                    },
                    child: const Text('Sign Up'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
