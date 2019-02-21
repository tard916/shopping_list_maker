import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'ui/home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List Maker',
      home: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new Home(),
        title: new Text(
          "Shopping List Maker",
          style: new TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 24.5
          ),
        ),
        image: new Image.asset('images/shopping_cart.png',
          height: 150,
          width: 150,
        ),
        backgroundColor: Colors.white70,
        loadingText: new Text("Develop By 224Tech",
          style: new TextStyle(
            height: 10.0,
            fontWeight: FontWeight.bold,
            fontSize: 12.5
          ),
        ),
        styleTextUnderTheLoader: new TextStyle(

        ),
          photoSize: 100.0,
        loaderColor: Colors.black
      ),
    );
  }
}

