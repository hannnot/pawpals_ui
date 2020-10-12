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
            child: Image(image: AssetImage('assets/images/pawPalsLogo.png'))
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My account'),
            onTap: () {
              // TODO implement account page
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // TODO make networkrequest to logout
              // Navigate to login screen
            },
          )
        ],
      ),
    );
  }
}
