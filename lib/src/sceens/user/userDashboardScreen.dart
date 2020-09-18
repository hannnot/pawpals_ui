import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/userDrawer.dart';

class UserDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      drawer: UserDrawer(token: arguments['auth']),
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      
    );
  }
}