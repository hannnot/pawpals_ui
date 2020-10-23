import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/adminDrawer.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      drawer: AdminDrawer(
        auth: arguments['auth'],
        userInfo: arguments['userInfo'],
      ),
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(child: CircleAvatar(radius: 50)),
              SizedBox(height: 20),
              Center(
                child: Text(arguments['userInfo']['firstname'],
                    style: TextStyle(fontSize: 20)),
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
                onPressed: () {}, //TODO add Request Sit screen
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
