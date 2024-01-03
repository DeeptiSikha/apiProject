import 'package:flutter/material.dart';
import 'package:untitled1/another%20sqlite_store_studinfo/signUp_database.dart';

class ShowSignUpData extends StatefulWidget {
  const ShowSignUpData({super.key});

  @override
  State<ShowSignUpData> createState() => _ShowSignUpDataState();
}

class _ShowSignUpDataState extends State<ShowSignUpData> {
  late DatabaseSignUp database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Detail'),
        backgroundColor: Colors.grey.shade200,
      ),
      body: FutureBuilder(
        future:database.getallData(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return Center(child: Text('No data found'),);
            }
          }
          return ListView.builder(itemBuilder: (context, index) => ListTile(
            title: Text(snapshot.data![index].email,style: TextStyle(fontSize: 18),),
            subtitle: Text(snapshot.data![index].pass),
            trailing: Row(
              children: [
                IconButton(icon: Icon(Icons.edit), onPressed: () {  },),
                IconButton(icon: Icon(Icons.delete), onPressed: () {  },),
              ],
            ),
          ),);
        },
      ),
    );
  }
}
