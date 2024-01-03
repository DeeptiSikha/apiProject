// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:untitled1/todoapp/service.dart';
// import 'package:untitled1/working_with_firebase/firebase%20service/data_service.dart';
// import 'package:untitled1/working_with_firebase/firebase%20service/service.dart';
//
// class AddPage extends StatefulWidget {
//   const AddPage({super.key});
//
//   @override
//   State<AddPage> createState() => _AddPageState();
// }
//
// class _AddPageState extends State<AddPage> {
//
//   final namecontroller=TextEditingController();
//   final desccontroller=TextEditingController();
//   late final DataService? database;
//
//   final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//
//     final nameField=TextFormField(
//       controller: namecontroller,
//       autofocus: false,
//       validator: (value){
//         if(value==null||value.trim().isEmpty){
//           return 'This field is required';
//         }
//       },
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         hintText: 'Name',
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(32)
//         )
//       ),
//     );
//
//     final descField=TextFormField(
//       controller: namecontroller,
//       autofocus: false,
//       validator: (value){
//         if(value==null||value.trim().isEmpty){
//           return 'This field is required';
//         }
//       },
//       decoration: InputDecoration(
//           contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: 'Description',
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(32)
//           )
//       ),
//     );
//
//     final viewButon=TextButton(onPressed: (){
//       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ListPage(),),
//               (route) => false);
//     },
//         child: const Text('View List of Employee')
//     );
//
//     final SaveButton=Material(
//       elevation: 5.0,
//       borderRadius: BorderRadius.circular(30.0),
//       color: Theme.of(context).primaryColor,
//       child: MaterialButton(
//         minWidth: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         onPressed: ()async{
//           if(_formkey.currentState!.validate()){
//             var response=await database!.createItem(
//                 namecontroller.text,
//                 desccontroller.text
//             );
//           }
//         },child: Text(
//         'Save',style: TextStyle(color: Theme.of(context).primaryColorLight),
//         textAlign: TextAlign.center,
//       ),
//       ),
//     );
//
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Text('Firebase CRUD'),
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Form(
//             key: _formkey,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   nameField,
//                   const SizedBox(height: 25.0,),
//                   descField,
//                   const SizedBox(height: 35.0,),
//                   viewButon,
//                   const SizedBox(height: 45.0,),
//                   SaveButton,
//                   const SizedBox(height: 15.0,),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class ListPage extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//    return _ListPage();
//   }
// }
//
// class _ListPage extends State<ListPage>{
//   late final DataService? database;
//
//   final Stream<QuerySnapshot> collectionRefrence=database.readItems();
//
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//      resizeToAvoidBottomInset: false,
//      appBar: AppBar(
//        title: const Text('Reading Data'),
//        backgroundColor: Theme.of(context).primaryColor,
//        actions: [
//          IconButton(onPressed: (){
//            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
//              builder: (context) => AddPage(),), (route) => false);
//          },
//              icon: Icon(Icons.app_registration,color: Colors.white,)),
//        ],
//      ),
//      body: StreamBuilder(
//        stream: collectionRefrence,
//        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
//
//        },
//      ),
//    );
//   }
//
// }
