import 'dart:convert';
import 'package:fb_series/api%20integration/user_api_get.dart';
import 'package:fb_series/api%20integration/user_model_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostApiExample extends StatefulWidget {
  const PostApiExample({super.key});

  @override
  State<PostApiExample> createState() => _PostApiExampleState();
}

class _PostApiExampleState extends State<PostApiExample> {

  final apiUrl = "https://jsonplaceholder.typicode.com/posts";

  final userIdController = TextEditingController();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> postData() async {
    UserModel user= UserModel(
        userId: int.parse(userIdController.text),
        title: titleController.text,
        body: bodyController.text
    );      
    await http.post(Uri.parse(apiUrl),
            headers: {"Content-Type": "application/json"},
            body:jsonEncode(user.toJson())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POST API Example'),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserApiGET(),));
          }, icon: const Icon(Icons.remove_red_eye))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: userIdController,
                decoration: const InputDecoration(hintText: 'User Id'),
              ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              TextFormField(
                controller: bodyController,
                decoration: const InputDecoration(hintText: 'Body'),
              ),
              ElevatedButton(onPressed: () {
                postData();
                setState(() {
                  userIdController.clear();
                  titleController.clear();
                  bodyController.clear();
                });
              },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
