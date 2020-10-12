import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/adminDrawer.dart';

class AdminAccountScreen extends StatelessWidget {
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
        title: Text('Admin Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FlatButton.icon(
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
            )
          ],
        ),
      ),
    );
  }
}
