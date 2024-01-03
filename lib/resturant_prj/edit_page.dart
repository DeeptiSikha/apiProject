import 'package:flutter/material.dart';
import 'package:untitled1/resturant_prj/food_database.dart';
import 'package:untitled1/resturant_prj/food_item_model.dart';
import 'package:untitled1/resturant_prj/food_showing_page.dart';

class EditFoodPage extends StatefulWidget {
  const EditFoodPage({super.key, required this.id,required this.fname, required this.desc, required this.price});
  final String fname;
  final String id;
  final String desc;
  final int price;
  @override
  State<EditFoodPage> createState() => _EditFoodPageState();
}

class _EditFoodPageState extends  State<EditFoodPage> {

  final dataBaseHelper=DataBaseHelper();
  final foodnamecontroller=TextEditingController();
  final desccontroller=TextEditingController();
  final pricecontroller=TextEditingController();


  @override
  void initState() {
    foodnamecontroller.text=widget.fname;
    desccontroller.text=widget.desc;
    pricecontroller.text=widget.price.toString();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    void editItem(){

      var edit=FoodItemModel(
          id:widget.id,
          foodname: foodnamecontroller.text,
          description: desccontroller.text,
          price:pricecontroller.text.isNotEmpty ? int.parse(pricecontroller.text):0
      );
      dataBaseHelper.editFood(edit);
      setState(() {
        foodnamecontroller.clear();
        desccontroller.clear();
        pricecontroller.clear();
      });
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
            ElevatedButton(
              onPressed: (){
              editItem();
              Navigator.push(context, MaterialPageRoute(builder: (context) => FoodShowingPage(),));
            },
              child: Text('Edit Items',style: TextStyle(color: Colors.purple.shade800),),
              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.purple.shade200)),
            )
          ],
        ),
      ),
    );
  }
}
