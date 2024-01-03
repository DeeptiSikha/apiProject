import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/screens/working_with_sqlite/planets.dart';

import 'database_class.dart';

class InputFile extends StatelessWidget {
  final dbService = DataBase();


  final  TextEditingController idcontroller=TextEditingController();

  final TextEditingController namecontroller=TextEditingController();

  final TextEditingController agecontroller=TextEditingController();

  final TextEditingController distancecontroller=TextEditingController();

  InputFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          child: Column(
            children: [
              TextField(
                controller: idcontroller,
                decoration: InputDecoration(
                    hintText: 'Enter Planet id',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black,width: 2)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black,width: 2)
                    )
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  hintText: 'Enter Planet name',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black,width: 2)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black,width: 2)
                  )
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: agecontroller,
                decoration: InputDecoration(
                    hintText: 'Enter Planet age',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black,width: 2)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black,width: 2)
                    )
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: distancecontroller,
                decoration: InputDecoration(
                    hintText: 'Enter Planet distance',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black,width: 2)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black,width: 2)
                    )
                ),
              ),
              ElevatedButton(onPressed: (){saveData();}, child: Text("Save"))
            ],
          ),
        ),
      ),
    );
  }

  void saveData(){
    Planets planets=new Planets(
      id: int.parse(idcontroller.text),
      name:namecontroller.text,
      age: int.parse(agecontroller.text),
      distancefromsun: int.parse(distancecontroller.text));
    Future<int> future=dbService.insertPlanets(planets as List<Planets>);
    future.then((value) {
      if(value!=null){
        print('result added'+value.toString());
      }
    });
  }

}
