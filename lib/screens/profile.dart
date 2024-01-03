import 'package:flutter/material.dart';
import 'package:untitled1/screens/practice.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key,required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MyHomePage();
          },));
        },icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),
      body: Stack(
        children: [
          Positioned(
              child: Container(
            height: 200,
            width: 400,
            color: Colors.grey,
            child: Positioned(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white,width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                          foregroundImage: AssetImage("assets/images/online-shopping.png"),
                          radius: 20,
                        ),
                      ),
                      Positioned(
                              child: Text(title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:18 ),)
                      ),
                    ],
                  ),
                )),
          )),
          Center(
            child: Container(
              height: 200,
              width: 350,
              //color: Colors.black,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.black,),
                        hintText: "User Name",
                        enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                      color: Colors.black,width: 2)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.black,width: 2
                          )
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock,color: Colors.black,),
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.black,width: 2)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.black,width: 2
                              )
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 440,left: 35,right: 35),
            child: GestureDetector(
              onTap: (){
                print("submited");
              },
              child: Container(
                height: 50,
                width: 390,
                child: Center(child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: Colors.black87,
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.home),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyHomePage();
              },));
            },),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
            BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.person_2_outlined),onPressed: (){
              Navigator.pushNamed(context, '/second');
            },),label: "Profile"),
          ],
        ),
      ),
    );
  }
}