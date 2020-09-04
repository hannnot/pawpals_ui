import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/sceens/homeScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PawPals',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.teal),
      ),
      home: HomeScreen(),
    );
  }
}
