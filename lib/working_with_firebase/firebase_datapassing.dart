// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:http_parser/http_parser.dart';
// import 'dart:convert';
//
// class DataPassingToFirebase extends StatefulWidget {
//   const DataPassingToFirebase({super.key});
//
//   @override
//   State<DataPassingToFirebase> createState() => _DataPassingToFirebaseState();
// }
//
// class _DataPassingToFirebaseState extends State<DataPassingToFirebase> {
//
//   final _form=GlobalKey<FormState>();
//   String? title;
//
//   void writeData() async{
//     _form.currentState!.save();
//     var url="DatabaseURL"+"data.json";
//     try {
//       final response=await http.post(
//           Uri.parse(url),
//           body:json.encode({"title":title}),
//       );
//     }catch(error){
//       throw error;
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Firebase Flutter & Real Time Database',
//
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Add Data To Firebase Database'),
//           backgroundColor: Colors.grey.shade100,
//         ),
//         body: Form(
//           key: _form,
//           child: Center(
//             child: Column(
//               children: [
//                 TextFormField(
//                   onSaved: (value){
//                     title=value;
//                   },
//                   decoration: InputDecoration(hintText: 'Enter the name'),
//                 ),
//                 SizedBox(height: 10,),
//                 ElevatedButton(onPressed: writeData, child: Text('Add Data'))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class ReadDataFromDataBase extends StatefulWidget {
//   const ReadDataFromDataBase({super.key});
//
//   @override
//   State<ReadDataFromDataBase> createState() => _ReadDataFromDataBaseState();
// }
//
// class _ReadDataFromDataBaseState extends State<ReadDataFromDataBase> {
//
//   void initState(){
//     super.initState();
//     readData();
//   }
//
//   bool isLOADING=true;
//   List<String> list=[];
//
//   Future<void> readData()async{
//     var url="DatabaseURL"+"data.json";
//     try{
//       final response=await http.get(Uri.parse(url));
//       final extractedData=json.decode(response.body) as Map<String,dynamic>;
//       if(extractedData==null){
//         return;
//       }
//       extractedData.forEach((blogId, blogData) {
//         list.add(blogData['title']);
//       });
//       setState(() {
//         isLOADING=false;
//       });
//     }catch(error){
//       throw error;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Realtime Databse read',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('The Data'),
//         ),
//         body: isLOADING?CircularProgressIndicator():ListView.builder(itemBuilder: (context, index) => Container(
//           height: 50,
//           child: Center(
//             child: Text(
//               list[index],
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ),),
//       ),
//     );
//   }
// }
