import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPExample extends StatefulWidget {
  const SPExample({super.key});

  @override
  State<SPExample> createState() => _SPExampleState();
}

class _SPExampleState extends State<SPExample> {

  final namecontroller=TextEditingController();
  final ageController=TextEditingController();

  SharedPreferences? sharedPF;

  String name="";
  int age=0;

  @override
  void initState(){
    super.initState();
    loadSharedPreference();
    getDataFromSP();
  }

  loadSharedPreference()async{
     sharedPF=await SharedPreferences.getInstance();
  }

  void addDataToSP(String name,int age)async{
    // final sharedPF=await SharedPreferences.getInstance();
    setState(() {
      sharedPF!.setString('name', name);
      sharedPF!.setInt('age', age);
    });
      namecontroller.clear();
      ageController.clear();
  }

  void deleteDataFromSP()async{
    //final sharedPF=await SharedPreferences.getInstance();
    setState(() {
      sharedPF!.remove('name');
      sharedPF!.remove('age');
    });
  }

  void getDataFromSP()async{
   // final sharedPF=await SharedPreferences.getInstance();
      setState(() {
        age=sharedPF!.getInt('age')??0;
        name=sharedPF!.getString('name')??"Null";
      });
  }


  @override
  Widget build(BuildContext context) {

    setState(() {
      getDataFromSP();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Adding Data SP'),
        backgroundColor: Colors.yellow.shade200,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
            child: Column(
              children: [
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      hintText: 'Name'
                  ),
                ),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Age'
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
                  child: InkWell(
                    onTap: () {
                      addDataToSP(
                          namecontroller.text,int.parse(ageController.text));
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      color: Colors.yellow.shade100,
                      child: Center(child: Text('Submit'),),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
                  child: InkWell(
                    onTap: () {
                      deleteDataFromSP();
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      color: Colors.yellow.shade100,
                      child: Center(child: Text('Delete'),),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  child: ListTile(
                    leading:Text("Name: "+name,style: TextStyle(fontSize: 26),),
                    trailing:Text("Age: "+age.toString(),style: TextStyle(fontSize: 20),),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
