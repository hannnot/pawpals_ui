import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: null, //TODO add homeScreen
    );
  }
}