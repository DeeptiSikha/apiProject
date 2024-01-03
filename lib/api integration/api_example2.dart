import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiCallExample2 extends StatefulWidget {
  const ApiCallExample2({super.key});
  @override
  State<ApiCallExample2> createState() => _ApiCallExample2State();
}


class _ApiCallExample2State extends State<ApiCallExample2> {

  bool isLoading=false;
  List<User> user=[];

  Future<List<User>> getData() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    List responseJson = json.decode(response.body.toString());
    if(responseJson.isNotEmpty){
      setState(() {
        user = createUserList(responseJson);
        isLoading=false;
      });
    }
    return user;
  }

  List<User> createUserList(List data) {
    List<User> list = [];
    for (int i = 0; i < data.length; i++) {
      String title = data[i]['title'];
      int id = data[i]['id'];
     // String body=data[i]['body'];
      User user = User(id: id, name: title);
      list.add(user);
    }
    return list;
  }

  @override
  void initState(){
    setState(() {
      isLoading=true;
    });
    getData();
    super.initState();
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
      body: isLoading?const Center(child: CircularProgressIndicator()):
          ListView.builder(
            itemCount: user.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(user[index].name),
                  leading: Text('${user[index].id}'),
                ),
              );
            },)
    );
  }
}

class User {
  String name;
  int id;

  User({required this.id, required this.name});
}

// FutureBuilder<List<User>>(
// future: getData(),
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// return ListView.builder(
// itemCount: snapshot.data!.length,
// itemBuilder: (context, index) {
// return Card(
// child: ListTile(
// leading: CircleAvatar(
// backgroundColor: Colors.orange.shade100,
// child: Text('${snapshot.data![index].id}')),
// title: Text(snapshot.data![index].name),
// ),
// );
// });
// }
// else if (snapshot.hasError) {
// return Text("${snapshot.error},${snapshot.data}");
// }
// return const CircularProgressIndicator();
// },
// ),