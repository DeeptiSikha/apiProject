import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  //Name
  List<String> name =[
    'Product 1','Product2','Product3','Product4','Product5','Product6','Product7','Product8','Product9'
  ];
  //desc
  List<String> desc=[
    'This is the description of the product1',
    'This is the description of the product2',
    'This is the description of the product3',
    'This is the description of the product4',
    'This is the description of the product5',
    'This is the description of the product6',
    'This is the description of the product7',
    'This is the description of the product8',
    'This is the description of the product9',

  ];
  //price
  List<int> price=[100,200,300,400,500,600,700,800,900];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Product Page"),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(child: Container(height: 100,width: 200,)),
            ListTile(leading:Icon(Icons.home),title: Text('Home'),onTap: (){
              Navigator.pushNamed(context, '/first');
            }),
            ListTile(leading:Icon(Icons.search),title: Text('Search'),onTap: (){
    Navigator.pushNamed(context, '/second');}),
            ListTile(leading:Icon(Icons.person_2),title: Text('Profile'),
    onTap: (){
    Navigator.pushNamed(context, '/third');}),
          ],
        ),
      ),
      backgroundColor: Colors.orange.shade50,
      body: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    DetailPage(pname: name[index], pdesc: desc[index], price: price[index]),));
              },
              child: Container(
                height: 100,
                width: double.infinity,
                color: Colors.lightBlue.shade50,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(name[index],style: TextStyle(fontSize: 18,color: Colors.blueAccent.shade700,fontWeight: FontWeight.bold),),
                        IconButton(onPressed: (){
                          showSnackBar(context, index);
                        }, icon: Icon(Icons.delete))
                      ],
                    ),
                    Text(desc[index],style: TextStyle(fontSize: 16,color: Colors.black54),),
                    Padding(
                      padding: const EdgeInsets.only(left: 200),
                      child: Text("\$"+price[index].toString(),style: TextStyle(fontSize: 20,color: Colors.black),),
                    ),

                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Card();
          },
          itemCount: name.length),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.home_filled),onPressed: (){
            Navigator.pushNamed(context, '/first');
          },),label: "Home",),
          BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.search_outlined),
          onPressed: (){
    Navigator.pushNamed(context, '/first');},),label: "Search"),
          BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.person_2),onPressed: (){
    Navigator.pushNamed(context, '/first');}),label: "Profile"),
        ],
      ),
    );
  }
  void showSnackBar(BuildContext context, int index) {
    var deletedRecord = name[index];
    setState(() {
      name.removeAt(index);
    });
    SnackBar snackBar = SnackBar(
      content: Text('Deleted $deletedRecord'),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {
          setState(() {
            name.insert(index, deletedRecord);
          });
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}



class DetailPage extends StatelessWidget {
   DetailPage({super.key,
   required this.pname,required this.pdesc,required this.price});


   final String pname,pdesc;
   final int price;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.pop(context);
        },),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
          ),
          Text(pname),
          SizedBox(height: 5,),
          Text(pdesc),
          SizedBox(height: 5,),
          Text(price.toString()),
        ],
      ),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      child:DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text("1 Tab"),
                ),
                Tab(
                  child: Text("1 Tab"),
                ),
                Tab(
                  child: Text("1 Tab"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(color: Colors.yellowAccent,),
              Container(color: Colors.purpleAccent,),
              Container(color: Colors.pinkAccent,)
            ],
          ),
        ),
      )
    );
  }
}
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
        child: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
    Navigator.pop(context);
    }));
  }
}
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
    child: IconButton(icon: Icon(Icons.arrow_back),onPressed: () {
      Navigator.pop(context);
    }));
  }
}
