import 'package:flutter/material.dart';
import 'package:untitled1/resturant_prj/edit_page.dart';
import 'package:untitled1/resturant_prj/food_database.dart';
import 'package:untitled1/resturant_prj/food_item_model.dart';


class FoodShowingPage extends StatefulWidget {
  const FoodShowingPage({super.key});

  @override
  State<FoodShowingPage> createState() => _FoodShowingPageState();
}

class _FoodShowingPageState extends State<FoodShowingPage> {

  final database=DataBaseHelper();
  void deleteItem(String id){
    database.deleteFood(id);
    setState(() { });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Food'),
        backgroundColor: Colors.purple.shade200,
      ),
      body: FutureBuilder<List<FoodItemModel>>(
        future: database.getalldata(),
        builder: (context, snapshot) => snapshot.data !=null?GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            children: List.generate(snapshot.data!.length, (index) => Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,  
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple)
                ),
                
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditFoodPage(
                            id:snapshot.data![index].id,
                            fname: snapshot.data![index].foodname,
                            desc: snapshot.data![index].description,
                            price: snapshot.data![index].price),
                        )
                    );
                  },
                  child: Column(
                    children: [
                      Text(snapshot.data![index].foodname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,fontStyle: FontStyle.normal),),
                      Text(snapshot.data![index].description,style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),),
                      Text("\$"+snapshot.data![index].price.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontStyle: FontStyle.normal),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(onPressed: (){deleteItem(snapshot.data![index].id);}, icon: Icon(Icons.delete)),
                          SizedBox(width: 5,),
                          IconButton(onPressed: (){
                            print("name-->${snapshot.data![index].foodname}");
                            print("des-->${snapshot.data![index].description}");
                            print("id-->${snapshot.data![index].id}");
                            print("pri-->${snapshot.data![index].price}");
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => EditFoodPage(
                                  id:snapshot.data![index].id,
                                  fname: snapshot.data![index].foodname,
                                  desc: snapshot.data![index].description,
                                  price: snapshot.data![index].price),
                              )
                            );
                          }, icon: Icon(Icons.edit)),
                        ]),
                    ] ,
                  ),
                ),
              ),
            ))
      ):SizedBox(),
      ),
    );
  }
}