import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AddData extends StatelessWidget {
  final valuecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("geeksforgeeks"),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(controller: valuecontroller,decoration: InputDecoration(hintText: 'Enter value'),),
            ),
            SizedBox(height: 10,),
            FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(Icons.add),
              onPressed: () {
                FirebaseFirestore.instance.collection('data').add({'text': valuecontroller.text});
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowData(),));
              },
            ),
          ],
        ),
      ),
    );
  }
}
class ShowData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("geeksforgeeks"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('data').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                child: Center(child: Text(document['text'])),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}