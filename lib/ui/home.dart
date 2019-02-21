import 'package:flutter/material.dart';
import 'package:shopping_list/ui/notodo_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Shopping List Maker",
        ),
        centerTitle: false,
        backgroundColor: Colors.blueAccent,
      ),

      body: new NotoDoScreen(),
    );
  }
}
