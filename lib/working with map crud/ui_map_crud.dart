import 'dart:convert';

import 'package:flutter/material.dart';

import 'model_map_user.dart';

class MapCRUDExample extends StatefulWidget {
  const MapCRUDExample({super.key});

  @override
  State<MapCRUDExample> createState() => _MapCRUDExampleState();
}

class _MapCRUDExampleState extends State<MapCRUDExample> {

  final namecontroller=TextEditingController();
  final agecontroller=TextEditingController();
  final profcontroller=TextEditingController();

  List<User> list=[];

  void add(User user){
    list.add(user);
  }

  void delete(int index){
    list.removeAt(index);
  }

  void update(User user,int index){
    list.setAll(index, [
      User(name: user.name, age: user.age, profession: user.profession)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map CRUD'),
        backgroundColor: Colors.brown.shade200,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller:namecontroller,
                    decoration: InputDecoration(
                      hintText: 'Name'
                    ),
                  ),
                  TextFormField(
                    controller:agecontroller,
                    decoration: InputDecoration(
                        hintText: 'Age'
                    ),
                  ),
                  TextFormField(
                    controller:profcontroller,
                    decoration: InputDecoration(
                        hintText: 'Profession'
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      add(User(name: namecontroller.text,
                          age: agecontroller.text,
                          profession: profcontroller.text)
                      );
                      setState(() {

                      });
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.brown.shade300
                      ),
                      child: Center(child: Text('SAVE',style: TextStyle(fontSize: 26,color: Colors.white,),),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: (){
                      namecontroller.text=list[index].name;
                      agecontroller.text=list[index].age;
                      profcontroller.text=list[index].profession;
                    },
                  ),
                  title: Text("${list[index].name}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${list[index].age}"),
                      Text("${list[index].profession}"),
                    ],
                  ),
                  trailing: IconButton(icon: Icon(Icons.delete),onPressed: (){
                    delete(index);
                    setState(() {

                    });
                  },),
                ),
              ),),
            ),
          )
        ],
      ),
    );
  }
}
