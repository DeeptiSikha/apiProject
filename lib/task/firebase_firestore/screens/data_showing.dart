import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_series/main.dart';
import 'package:fb_series/task/firebase_firestore/screens/another%20ui/register_form.dart';
import 'package:fb_series/task/firebase_firestore/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/databaseService.dart';
import 'another ui/tabbarpage.dart';

/// form registration global instance declaration
FormRegister  formRegisterdata = FormRegister();

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});
  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {

  int counter=0;

  /// all field controller variable
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final dobcontroller = TextEditingController();
  final namecontroller = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.deepPurple.shade50,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, mainAxisExtent: 200),
                children: snapshot.data!.docs.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding:
                            const EdgeInsets.only(left: 15, right: 10, top: 20),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.shade200,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// data shown in Column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name : ' + e['name'],
                                  style: TextStyle(fontSize: 26),
                                ),
                                Text(
                                  'Email : ' + e['email'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Date of Birth : ' + e['dob'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Password : ' + e['password'],
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                /// icon button for edit
                                IconButton(
                                    onPressed: () {
                                      tabController!.index = 1;
                                      /// this is data passing sections where the data is passed to the register page for updation
                                      formRegisterdata = FormRegister(
                                            id: e.id,
                                            title: 'Update',
                                            isEditing: true,
                                            pass: e['password'],
                                            dob: e['dob'],
                                            name: e['name'],
                                            email: e['email'],
                                      );
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      size: 26,
                                    )),
                                /// icon button for delete
                                IconButton(
                                    onPressed: () async {
                                      await FirebaseService.deleteData(
                                          id: e.id);
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("Successful"),
                                          content: const Text(
                                              "Record Deleted Successfully"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Container(
                                                color:
                                                    Colors.deepPurple.shade500,
                                                padding:
                                                    const EdgeInsets.all(14),
                                                child: const Text(
                                                  "okay",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 26,
                                    )),
                              ],
                            )
                          ],
                        )),
                  );
                }).toList(),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        stream: FirebaseService.getData(),
      ),
    );
  }
}
