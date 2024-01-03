import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Employee{
  String name,contact;

  Employee({required this.name,required this.contact});
}

class AnotherListOpearation extends StatefulWidget {
  const AnotherListOpearation({super.key});

  @override
  State<AnotherListOpearation> createState() => _AnotherListOpearationState();
}

class _AnotherListOpearationState extends State<AnotherListOpearation> {

  List<Employee> employee=[];


  final namecontroller=TextEditingController();
  final nocontroller=TextEditingController();

  int selectedIndex=-1;

  void addData(){
    employee.add(Employee(name: namecontroller.text, contact: nocontroller.text));
    setState(() {

    });
    namecontroller.clear();
    nocontroller.clear();
  }

  @override
  void initState(){
    super.initState();
    _loadValue();
  }

  int counter=0;
  int clickedIndex=0;

  void _loadValue()async{
    final sharedPref=await SharedPreferences.getInstance();
    setState(() {
      counter=(sharedPref.getInt('counter')??0);
    });
  }

  void increamentValue()async{
    final sharedPref=await SharedPreferences.getInstance();
    setState(() {
      counter=(sharedPref.getInt('counter') ?? 0)+1;
      sharedPref.setInt('counter', counter);
    });
  }

  void decrementValue()async{
    final sharedPref=await SharedPreferences.getInstance();
    setState(() {
      counter=(sharedPref.getInt('counter') ?? 0)-1;
      sharedPref.setInt('counter', counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List CRUD'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller:namecontroller,
                    decoration: InputDecoration(
                      hintText: 'Name'
                    ),
                    validator: (value) {
                      if(value!.isNotEmpty){
                        return 'Fill The field';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller:nocontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Number'
                    ),
                    validator: (value) {
                      if(value!.isNotEmpty){
                        return 'Fill The field';
                      }
                      return null;
                    },
                  ),
                  Padding(padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: (){
                            addData();
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            color: Colors.grey.shade300,
                            child: Center(child: Text('Save'),),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            if(employee.isNotEmpty) {
                              String name = namecontroller.text.trim();
                              String no = nocontroller.text.trim();
                              employee.setAll(selectedIndex, [
                                Employee(name: name,
                                    contact: no,)
                              ]);
                              setState(() {

                              });
                            }
                            namecontroller.clear();
                            nocontroller.clear();
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            color: Colors.grey.shade300,
                            child: Center(child: Text('Update'),),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Container(
              width: 400,
              child: Container(
                child: ListView.builder(
                  itemCount: employee.length,
                  itemBuilder: (context, index) => getRow(index),),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget getRow(int index){
    return Card(
      child: ListTile(
        title: Text('Name: '+employee[index].name.toUpperCase()),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Number: '+employee[index].contact),
            Text("Counter: "+counter.toString())
          ],
        ),
        selected: index==clickedIndex,
        onLongPress: (){
          increamentValue();
         setState(() {
           clickedIndex=index;
         });
        },
        leading: IconButton(
          icon: Icon(Icons.edit),
          onPressed: (){
            namecontroller.text=employee[index].name;
            nocontroller.text=employee[index].contact;
            selectedIndex=employee.indexOf(employee[index]);
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete), onPressed: () {
            employee.remove(employee[index]);
            setState(() {  });
        },
        )
      ),
    );
  }
}
