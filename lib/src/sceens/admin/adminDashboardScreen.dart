import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/adminDrawer.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(token: null,),
      appBar: AppBar(
        title: Text('Welcome'),
      ),
    );
  }
}