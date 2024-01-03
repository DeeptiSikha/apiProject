import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart'show rootBundle ;


class LoadJsonData extends StatefulWidget {
  const LoadJsonData({super.key});

  @override
  State<LoadJsonData> createState() => _LoadJsonDataState();
}

class _LoadJsonDataState extends State<LoadJsonData> {

  var jsonData="";

  Future<void> getData()async{
    final String response=await rootBundle.loadString("assets/data.json");
    var data=json.decode(response);
    setState(() {
      jsonData=data;
    });
  }

  Future<List<User>> getDataJson() async {
    final String response = await rootBundle.loadString("assets/data.json");
    List responseJson = json.decode(response);
    List<User> userList = createUserList(responseJson);
    return userList;
  }

  List<User> createUserList(List data) {
    List<User> list = [];
    for (int i = 0; i < data.length; i++) {
      String title = data[i]['name'];
      String email=data[i]['email'];
      int age = data[i]['age'];
      User user = User(email:email, name: title, age: age);
      list.add(user);
    }
    return list;
  }


  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Api Call Example of User',
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange.shade200,
      ),
      body: FutureBuilder<List<User>>(
        future: getDataJson(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.orange.shade100,
                          child: Text('${snapshot.data![index].age}')),
                      title: Text(snapshot.data![index].name),
                      trailing: Text(snapshot.data![index].email),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error},${snapshot.data}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
class User{
  String name,email;
  int age;
  User({required this.name,required this.age,required this.email});
}