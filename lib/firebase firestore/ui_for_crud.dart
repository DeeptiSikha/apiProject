import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/firebase%20firestore/databaseFile.dart';
import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {

  final namecontroller=TextEditingController();
  final emailcontroller=TextEditingController();
  final phonecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(child: Text('See th data'),onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ListUsers(),));},),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add User',style: TextStyle(fontSize: 26,color: Colors.grey.shade700,fontWeight: FontWeight.bold),),
            Container(
              padding: const EdgeInsets.only(top: 30,left: 10,right: 10),
              child: Column(
                children: [
                  TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(hintText: "User Name"),
                  ),
                  TextField(
                    controller: phonecontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Phone Number"),
                  ),
                  TextField(
                    controller: emailcontroller,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: () async{
                await FirebaseFirestoreService.addUser(
                    name: namecontroller.text,
                    phone: phonecontroller.text,
                    email: emailcontroller.text
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) =>ListUsers() ,));
              },
              child: Container(
                height: 50,
                width: 150,
                color: Colors.grey.shade200,
                child: Center(child: Text("Add Data")),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {

  final Stream<QuerySnapshot> collection=FirebaseFirestoreService.readUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Data'),
      ),
      body: StreamBuilder(
          stream: collection,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView(
                  children: snapshot.data!.docs.map((e) {
                    return Card(
                        child: Column(children: [
                          ListTile(
                            onTap: (){

                            },
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: ()async{
                                FirebaseFirestoreService.deleteUser(id: e.id);
                              },
                            ),
                            leading: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: ()async{
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    EditPage(id: e.id, name:e["name"] , email: e['email'], phone: e['phone']),));
                              },
                            ),
                            title: Text(e["name"]),
                            subtitle: Container(
                              child: (Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Contact No: " + e['phone'],
                                      style: const TextStyle(fontSize: 14)),
                                  Text("Email Id: " + e['email'],
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              )),
                            ),
                          ),
                        ]));
                  }).toList(),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }
          ),
    );
  }
}

class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.id, required this.name, required this.email, required this.phone});

  final String id;
  final String name;
  final String email;
  final String phone;


  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  final namecontroller=TextEditingController();
  final emailcontroller=TextEditingController();
  final phonecontroller=TextEditingController();
  final idcontroller=TextEditingController();

  void initState(){
    super.initState();
    idcontroller.text=widget.id;
    namecontroller.text=widget.name;
    emailcontroller.text=widget.email;
    phonecontroller.text=widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
        child: Column(
          children: [
            TextField(
              controller: idcontroller,
              readOnly: true,
            ),
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                hintText: 'Username'
              ),
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email'
              ),
            ),
            TextField(
              controller: phonecontroller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.call),
                  hintText: 'Phone Number'
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: () async{
                await FirebaseFirestoreService.editUser(
                    name: namecontroller.text,
                    phone: phonecontroller.text,
                    email: emailcontroller.text,
                    id: idcontroller.text
                );
                Navigator.of(context).pop();
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200
                ),
                child: Center(child: Text('Update Data')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
