import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
   NextPage({super.key,required this.data});
final String data;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(data)),
    );
  }
}
