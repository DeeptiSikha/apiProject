import 'package:flutter/material.dart';
import 'package:untitled1/screens/next_Page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final String data="The value";
  List<String> fruits=["apple","oranges","banana","mango"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black38,
                borderRadius: BorderRadius.circular(12)
              ),
            )
          );
        },
      ),
    );
  }
}
