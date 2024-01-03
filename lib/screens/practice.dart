import 'package:flutter/material.dart';
import 'package:untitled1/screens/gridview_page.dart';
import 'package:untitled1/screens/profile.dart';
import 'package:untitled1/screens/registration_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Scaffold Related Widget",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ScaffoldPage(),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: Colors.black87,
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
            BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.person_2_outlined),onPressed: (){
              Navigator.pushNamed(context, '/second');
            },),label: "Profile"),
          ],
        ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       DrawerHeader(
      //           decoration: BoxDecoration(color: Colors.white,)

      //           child: Container(
      //         height: 200,
      //         decoration: BoxDecoration(
      //           color: Colors.black54
      //         ),
      //       )),
      //       ListTile(
      //         title: Text("Home"),
      //       ),
      //       ListTile(
      //         title: Text("Search"),
      //       ),
      //       ListTile(
      //         title: Text("Cart"),
      //       ),
      //       ListTile(
      //         title: Text("Profile"),
      //       )
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.black87,
        onPressed: () {  },
        child: Icon(Icons.arrow_drop_up,color: Colors.white,size: 30,),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.white,),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.black54
                  ),
                )),
            ListTile(
              title: InkWell(
                child: Text("Registration"),
                onTap: (){
                  //Navigator.push(context,MaterialPageRoute(builder: (context) => RegistrationPage(),));
                },
              ),
            ),
            ListTile(
              title: InkWell(child: Text("GridView Page"),
              onTap: (){
               // Navigator.push(context,MaterialPageRoute(builder: (context) => GridViewPage(),));
              },),
            ),
            ListTile(
              title: Text("Cart"),
            ),
            ListTile(
              title: Text("Profile"),
            )
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
class ScaffoldPage extends StatelessWidget {
   ScaffoldPage({super.key});


  var image=["assets/images/online-shopping.png","assets/images/shopping-bag.png","assets/images/shopping-cart.png"];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
        color: Colors.black12,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage("http://via.placeholder.com/200x150"),
                      fit: BoxFit.cover)
              ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: image.length,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    //height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2,color: Colors.grey),
                      image: DecorationImage(
                        image: AssetImage(image[index]),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                );
              },),
            )
          ),
          SizedBox(height: 10,),
          Container(
            height: 50,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
          ),
          SizedBox(height: 5,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    height: 100,
                    width: 372,
                    color: Colors.grey,
                    child: Center(
                      child: Text("Lets check more",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    height: 100,
                    width: 372,
                    color: Colors.grey,
                    child: Center(
                      child: Text("Lets check more",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    height: 100,
                    width: 372,
                    color: Colors.grey,
                    child: Center(
                      child: Text("Lets check more",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

