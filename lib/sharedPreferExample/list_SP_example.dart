import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model_list.dart';

class ListSPFExample extends StatefulWidget {
  const ListSPFExample({super.key});

  @override
  State<ListSPFExample> createState() => _ListSPFExampleState();
}

class _ListSPFExampleState extends State<ListSPFExample> {

  SharedPreferences? sharedPreferences;

  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  List<PersonModel> list = [];

  int selectedIndex=-1;

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  Future<List<PersonModel>> loadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? listString = pref.getStringList('list');
    if (listString != null) {
      setState(() {
        list = listString.map((e) => PersonModel.fromMap(json.decode(e))).toList();
      });
    }
    return [];
  }

  void addItem(PersonModel personModel) {
    list.add(personModel);
    saveData();
  }

  void delete(int id) {
    setState(() {
      list.removeAt(id);
    });
    saveData();
  }

  void update(PersonModel personModel, int id) {
    setState(() {
      list.setAll(id, [
        PersonModel(
            name: personModel.name,
            age: personModel.age,
            phone: personModel.phone)
      ]);
    });
    saveData();
  }

  void saveData() async {
    List<String> userlist = list.map((e) => jsonEncode(e.toMap())).toList();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('list', userlist);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Adding To SP'),
        backgroundColor: Colors.indigo.shade200,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(hintText: 'Name'),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              TextFormField(
                controller: agecontroller,
                decoration: InputDecoration(hintText: 'Age'),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              TextFormField(
                controller: phonecontroller,
                decoration: InputDecoration(hintText: 'Phone Number'),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      addItem(PersonModel(
                          name: namecontroller.text,
                          age: agecontroller.text,
                          phone: phonecontroller.text));
                      namecontroller.clear();
                      agecontroller.clear();
                      phonecontroller.clear();
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      color: Colors.indigo.shade100,
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      update(PersonModel(
                          name: namecontroller.text,
                          age: agecontroller.text,
                          phone: phonecontroller.text
                      ),selectedIndex);
                      namecontroller.clear();
                      agecontroller.clear();
                      phonecontroller.clear();
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      color: Colors.indigo.shade100,
                      child: Center(
                        child: Text(
                          'Update',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
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
                          onPressed:(){
                            namecontroller.text=list[index].name!;
                            agecontroller.text=list[index].age!;
                            phonecontroller.text=list[index].phone!;
                            selectedIndex=index;
                          },),
                        title: Text('${list[index].name}'),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${list[index].age}'),
                            Text('${list[index].phone}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            //delete('${list[index]}');
                            delete(index);
                            //print("index$index");
                          },
                        ),
                      ),
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

class LoadData extends StatefulWidget {
  const LoadData({Key? key}) : super(key: key);

  @override
  _LoadDataState createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData> {
  List<PersonModel> list = [];
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  Future<List<PersonModel>> loadData() async {
    List<String>? listString = sharedPreferences!.getStringList('list');
    if (listString != null) {
      setState(() {
        print("Inside the set state");
        list = listString
            .map((item) => PersonModel.fromMap(json.decode(item)))
            .toList();
      });
      print("Length of list is---->");
      print(list.length);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Load Data"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          print("Length Is----->");
          print(list.length);
          return ListTile(
            title: Text('${list[index].name}'),
            subtitle: Text('${list[index].age}'),
          );
        },
      ),
    );
  }
}
