import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  final auth;
  final userInfo;

  UserDrawer({@required this.auth, @required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Image(image: AssetImage('assets/images/pawPalsLogo.png'))),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.of(context).pushNamed('/user-dashboard', arguments: {
                'auth': auth,
                'userInfo': userInfo,
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My account'),
            onTap: () {
              Navigator.of(context).pushNamed('/user-account', arguments: {
                'auth': auth,
                'userInfo': userInfo,
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/settings',
                  arguments: {'userInfo': userInfo, 'auth': auth});
            },
          ),
          SizedBox(height: 150),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
