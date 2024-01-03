import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}


class _AnimationPageState extends State<AnimationPage> {

  Widget _box(){
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey,
    );
  }

  Widget _boxSecond(){
    return Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text('Animation'),
      ),body: buildDemoWidget(context),
    );
  }
  Widget buildDemoWidget(BuildContext context){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          ListTile(
            leading: GestureDetector(
              child: Hero(
                tag: 'animationbox',
                child: _box(),
              ),
              onTap: ()=>detailPage(context),
            ),
          )
        ],
      ),
    );
  }
  void detailPage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(tag: 'animationbox', child: _boxSecond())
          ],
        ),
      ),
    ),));
  }
}
class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() => _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  double _height=100;
  double _width=100;
  Color _color=Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 5000),
          height: _height,
          width: _width,
          color: _color,
          curve: Curves.easeInOutBack,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: _update,
      ),

    );

  }
  final random = Random();

  void _update() {
    setState(() {
      _width = random.nextInt(300).toDouble();
      _height = random.nextInt(300).toDouble();
      _color = Color.fromRGBO(
        random.nextInt(128),
        random.nextInt(128),
        random.nextInt(128),
        1,
      );
    });
  }
}

class TweenAnimationPage extends StatefulWidget {
  const TweenAnimationPage({super.key});

  @override
  State<TweenAnimationPage> createState() => _TweenAnimationPageState();
}

class _TweenAnimationPageState extends State<TweenAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<double>(
          // 1. add a Duration
          duration: Duration(milliseconds: 500),
          // 2. add a Tween
          tween: Tween(begin: 0.0, end: 1.0),
          // 3. add a child (optional)
          child: Container(width: 120, height: 120, color: Colors.red),
          // 4. add the buiilder
          builder: (context, value, child) {
            // 5. apply some transform to the given child
            return Transform.translate(
              offset: Offset(value * 200 - 100, 0),
              child: child,
            );
          },
        ),
      ),
    );
  }
}



//animation 2
class FadeInDemo extends StatefulWidget {
  const FadeInDemo({super.key});

  @override
  State<FadeInDemo> createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {

  double opacity=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(image: AssetImage("assets/images/shopping-cart.png")),
          TextButton(onPressed:()=> setState(() {
            opacity=1;
          }),
              child: Text('Show Data')),
          AnimatedOpacity(
              opacity:opacity, duration: Duration(milliseconds: 2000),
            child: Column(
              children: [
                Text('the data 1'),
                Text('the data 2'),
                Text('the data 3'),
                Text('the data 4'),
              ],
            ),
          )
        ],
      ),
    );
  }

}
const _duration = Duration(milliseconds: 400);

double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

double randomMargin() {
  return Random().nextDouble() * 64;
}

Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({super.key});

  @override
  State<AnimatedContainerDemo> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  late Color color;
  late double borderRadius;
  late double margin;

  @override
  void initState() {
    super.initState();
    color = randomColor();
    borderRadius = randomBorderRadius();
    margin = randomMargin();
  }
  void _change(){
    setState(() {
      color=randomColor();
      borderRadius=randomBorderRadius();
      margin=randomMargin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: AnimatedContainer(
                margin: EdgeInsets.all(margin),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(borderRadius),
                ), duration: _duration,
              ),
            ),
            ElevatedButton(
              child: const Text('Change'),
              onPressed: () => _change(),
            ),
          ],
        ),
      ),
    );
  }
}

// splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
  void initState(){
    super.initState();
   Timer(
     Duration(seconds: 3),
       ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SecondScreen(),)),
   );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: 1,
          duration: Duration(milliseconds: 250),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children:[
            Icon(Icons.home,size: 80,color: Colors.purpleAccent,),
            Text("Sweet Home",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.purple),)
          ],)
        ),
      ),
    );
  }
}
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
