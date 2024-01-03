import 'dart:convert';

import 'package:fb_series/api%20integration/user_model_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class UserApiGET extends StatefulWidget {
  const UserApiGET({super.key});

  @override
  State<UserApiGET> createState() => _UserApiGETState();
}

class _UserApiGETState extends State<UserApiGET> {


  Future<List<UserModel>> getData() async {
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    List jsonData=json.decode(response.body.toString());
    List<UserModel> userList=createList(jsonData);
    return userList;
  }

  List<UserModel> createList(List data){
    List<UserModel> list=[];
    for(int i=0;i< data.length;i++){
      int userid=data[i]['userId'];
      int id=data[i]['id'];
      String title=data[i]['title'];
      String body=data[i]['body'];
      
      UserModel userModel=UserModel(userId: userid, id: id, title: title, body: body);
      list.add(userModel);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User API GET'),
        backgroundColor: Colors.grey.shade100,
      ),
      body: FutureBuilder<List<UserModel>>(
        future:getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) =>
                   Card(
                    child:  ListTile(
                      leading: Text('${snapshot.data![index].id}'),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${snapshot.data![index].userId}'),
                          Text(snapshot.data![index].title),
                        ],
                      ),
                      subtitle: Text(snapshot.data![index].body),
                    ),
                  ),);
          } else if (snapshot.hasError) {
            return  Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
