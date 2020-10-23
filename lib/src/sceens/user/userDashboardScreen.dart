import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/userDrawer.dart';

class UserDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      drawer: UserDrawer(
        auth: arguments['auth'],
        userInfo: arguments['userInfo'],
      ),
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: CircleAvatar(radius: 40)),
              SizedBox(height: 10),
              Center(
                child: Text(arguments['userInfo']['firstname']),
              ),
              SizedBox(height: 50),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {}, //TODO add Browse Sits screen
                child: Container(
                  width: 150,
                  child: Center(child: Text('Browse Sits')),
                ),
                color: Colors.teal[200],
              ),
              SizedBox(height: 15),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/request-sit', arguments: {
                    'auth': arguments['auth'],
                    'userInfo': arguments['userInfo'],
                  });
                }, 
                child: Container(
                  width: 150,
                  child: Center(child: Text('Request Sit')),
                ),
                color: Colors.teal[200],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
