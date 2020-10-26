import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/userDrawer.dart';

class UserAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      drawer: UserDrawer(
        auth: arguments['auth'],
        userInfo: arguments['userInfo'],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: FlatButton.icon(
                  onPressed: () => Navigator.of(context).pushNamed('/change-pwd',
                      arguments: {
                        'auth': arguments['auth'],
                        'userInfo': arguments['userInfo']
                      }),
                  icon: Icon(Icons.lock),
                  label: Text('Change password'),
                  color: Colors.teal[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
