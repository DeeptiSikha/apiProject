import 'package:flutter/material.dart';

class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          scrollDirection: Axis.vertical,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          children: List.generate(12, (index) => CardPage())
        ),
      ),
    );
  }
}
class CardPage extends StatefulWidget {
   CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  var image=["assets/images/online-shopping.png","assets/images/shopping-bag.png",
    "assets/images/shopping-cart.png","assets/images/online-shopping.png",
    "assets/images/online-shopping.png","assets/images/online-shopping.png",
    "assets/images/online-shopping.png",
    "assets/images/online-shopping.png","assets/images/online-shopping.png",
    "assets/images/online-shopping.png",];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/shopping-cart.png")
        )
      ),
    );
  }
}
