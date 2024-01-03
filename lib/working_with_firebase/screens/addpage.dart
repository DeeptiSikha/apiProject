import 'package:flutter/material.dart';
import 'package:untitled1/working_with_firebase/firebase%20service/firebase_crud.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final empnamecontroller=TextEditingController();
  final emppositioncontroller=TextEditingController();
  final contactcontroller=TextEditingController();

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  


  @override
  Widget build(BuildContext context) {
    final nameField=TextFormField(
      controller: empnamecontroller,
      autofocus: false,
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return 'This field is required';
        }
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0))),
    );

    final positionField=TextFormField(
      controller: emppositioncontroller,
      autofocus: false,
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return 'This field is required';
        }
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Position",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0))),
    );

    final contactField=TextFormField(
      controller: contactcontroller,
      autofocus: false,
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return 'This field is required';
        }
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contact No",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0))),
    );

    final viewListbutton=TextButton(onPressed:(){
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (context) => ListPage(),), (route) => false);
    } ,
        child: const Text('View List of Employee'));

    final saveButton=Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0,15.0),
        onPressed: ()async{
          if(_formKey.currentState!.validate()){
            var response=await FirebaseCrud.addEmployee(
                name: empnamecontroller.text,
                position: emppositioncontroller.text,
                contactno: contactcontroller.text
            );
            if(response.code!=200){
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  content: Text(response.message.toString()),
                );
              },);
            }else{
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  content: Text(response.message.toString()),
                );
              },);
            }
          }
        },child: Text(
        "Save",
        style: TextStyle(color: Theme.of(context).primaryColorLight),
        textAlign: TextAlign.center,
      ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Firebase work'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: _formKey,
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                nameField,
                const SizedBox(height: 25.0,),
                positionField,
                const SizedBox(height: 35.0,),
                contactField,
                viewListbutton,
                const SizedBox(height: 45.0,),
                saveButton,
                const SizedBox(height: 15.0,),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
