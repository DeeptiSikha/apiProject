
import 'package:flutter/material.dart';


class Person {
  //modal class for Person object
  String name, phone, address;

  Person({ required this.name, required this.phone, required this.address});
}


class MyApp2 extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
  List<Person> persons= [];

  final formkey=GlobalKey<FormState>();

  final namecontroller=TextEditingController();
  final nocontroller=TextEditingController();
  final addcontroller=TextEditingController();

  void adddata(){
    persons.add(Person(name: namecontroller.text, phone: nocontroller.text, address: addcontroller.text));
  }
  Person? person;

 int selectedIndex=-1;

  bool readonly=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text("Add And Delete List"),
          backgroundColor: Colors.grey.shade300,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                child: Container(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: namecontroller,
                          decoration: InputDecoration(hintText: 'Name'),
                        ),
                        TextFormField(
                          controller: nocontroller,
                          decoration: InputDecoration(hintText: 'Number'),
                        ),
                        TextFormField(
                          controller: addcontroller,
                          decoration: InputDecoration(hintText: 'address'),
                        ),
                        SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    adddata();
                                    setState(() { });
                                    namecontroller.clear();
                                    addcontroller.clear();
                                    nocontroller.clear();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    color: Colors.grey.shade500,
                                    child: Center(child: Text('Add Data',style: TextStyle(fontSize: 20,color: Colors.white),),),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    persons.setAll(selectedIndex, [
                                      Person(
                                          name: namecontroller.text,
                                          phone: nocontroller.text,
                                          address: addcontroller.text
                                      )
                                    ]);
                                    setState(() { });
                                    namecontroller.clear();
                                    addcontroller.clear();
                                    nocontroller.clear();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    color: Colors.grey.shade500,
                                    child: Center(child: Text('Update Data',style: TextStyle(fontSize: 20,color: Colors.white),),),
                                  ),
                                ),
                              ],
                            ),
                          ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: persons.map((personone){
                      return Container(
                        child: Card(
                          child:ListTile(
                            title: Text(personone.name),
                            subtitle: Text(personone.phone + "\n" + personone.address),
                            leading:  ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey.shade500
                              ),
                              child: Icon(Icons.edit,color: Colors.white,),
                              onPressed: (){
                                namecontroller.text=personone.name;
                                nocontroller.text=personone.phone;
                                addcontroller.text=personone.address;
                                selectedIndex=persons.indexOf(personone);
                              },
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey.shade500
                              ),
                              child: Icon(Icons.delete,color: Colors.white,),
                              onPressed: (){
                                persons.remove(personone);
                                setState(() {
                                });
                              },
                            ),
                          ),
                        ),

                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        )

    );
  }
}
