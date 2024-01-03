import 'package:flutter/material.dart';
import 'package:untitled1/resturant_prj/food_database.dart';
import 'package:untitled1/resturant_prj/food_item_model.dart';
import 'package:untitled1/resturant_prj/food_showing_page.dart';
import 'package:uuid/uuid.dart';
class AddFoodPage extends StatefulWidget {
  const AddFoodPage({super.key});

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {

  final dataBaseHelper=DataBaseHelper();
  final foodnamecontroller=TextEditingController();
  final desccontroller=TextEditingController();
  final pricecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {

    void addItem(){
      var add=  FoodItemModel(
          id: Uuid().v4(),
          foodname: foodnamecontroller.text,
          description: desccontroller.text,
          price: int.parse(pricecontroller.text)
      );
      dataBaseHelper.insertFood(add);
      setState(() { });
      foodnamecontroller.clear();
      desccontroller.clear();
      pricecontroller.clear();
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Add Food Items',style: TextStyle(color: Colors.purple.shade800,fontSize: 25,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.purple.shade100,
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => FoodShowingPage(),));
          },
              child: Text('See Data',style: TextStyle(fontSize: 20),)
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20,right: 10,left: 10),
        child: Column(
          children: [
            TextField(
              controller: foodnamecontroller,
              decoration: InputDecoration(hintText: 'Enter food name'),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: desccontroller,
              decoration: InputDecoration(hintText: 'Enter description'),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: pricecontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter price'),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              addItem();
              Navigator.push(context, MaterialPageRoute(builder: (context) => FoodShowingPage(),));
            },
                child: Text('Add Items',style: TextStyle(color: Colors.purple.shade800),),
              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.purple.shade200)),
            )
          ],
        ),
      ),
    );
  }
}
