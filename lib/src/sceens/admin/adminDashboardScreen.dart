import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/adminDrawer.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      drawer: AdminDrawer(
        token: arguments['auth'],
      ),
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Center(child: CircleAvatar(radius: 40)),
            SizedBox(height: 10),
            Center(
              child: Text(arguments['userInfo']['firstname']),
            ),
            SizedBox(height: 30),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: null, //TODO add Browse Sits screen
              child: Container(
                width: 150,
                child: Text('Browse Sits'),
              ),
              color: Colors.teal[200],
            ),
            SizedBox(height: 15),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: null, //TODO add Request Sit screen
              child: Container(
                width: 150,
                child: Text('Request Sit'),
              ),
              color: Colors.teal[200],
            ),
          ],
        ),
      ),
    );
  }
}
