import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState(){
    super.initState();
    Timer(
      Duration(seconds: 3),
        ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OnBoardingScreen(),))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.ac_unit,size: 50,color: Colors.deepPurpleAccent,),
              Text("Star Selections",style: TextStyle(fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: 50,),
            Icon(Icons.ac_unit,size: 80,color: Colors.deepPurpleAccent,),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Text("Welcome to star selection's.This is the on boarding screen frist page.Click on next to move on..",style: TextStyle(fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 400,right: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  child: Container(
                      width: 100,
                      height: 50,
                      child: Center(child: Text("Next >",style: TextStyle(fontSize: 20),))),
                  onPressed: ()=>(),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
