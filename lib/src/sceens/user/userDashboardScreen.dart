import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/userDrawer.dart';

class UserDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserDrawer(token: null),
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      
    );
  }
}