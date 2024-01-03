import 'package:flutter/material.dart';
import 'package:untitled1/screens/practice.dart';
import 'package:untitled1/screens/profile.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final mycontroler=TextEditingController();
  @override
  void dispose(){
    mycontroler.dispose();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.black54,
                ),
                child: Center(child: Text("Sign Up",style: TextStyle(fontSize: 30),)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: mycontroler,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined,color: Colors.black,),
                    hintText: "Email",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Colors.black,width: 2
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Colors.black,width: 2)
                    ),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter email properly";
                    }
                    return null;
                  },
                )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.call,color: Colors.black,),
                      hintText: "Phone Number",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.black,width: 2
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.black,width: 2)
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter phone number";
                      }
                      return null;
                    },
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password,color: Colors.black,),
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.black,width: 2
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Colors.black,width: 2)
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter password";
                      }
                      return null;
                    },
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a Snackbar.
                      final snackBar = SnackBar(
                        backgroundColor: Colors.grey,
                        content: Text('Successfully SignUp'),
                        duration: Duration(seconds: 5),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(title:mycontroler.text),));
                  },
                  child: Container(
                    height: 50,
                    width: 390,
                    child: Center(child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
