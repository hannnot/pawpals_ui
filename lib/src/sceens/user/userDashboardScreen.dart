import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/adminDrawer.dart';
import 'package:pawpals_ui/src/widgets/userDrawer.dart';

class UserDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      drawer: AdminDrawer(token: arguments['auth']), // Needs to be changed back to userDrawer when roles are implemented
      appBar: AppBar(
        title: Text('Welcome'),
      ),
    );
  }
}