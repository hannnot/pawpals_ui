import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pawpals_ui/src/consts.dart' as consts;

class UserDrawer extends StatelessWidget {
  final auth;
  final userInfo;

  UserDrawer({@required this.auth, @required this.userInfo});

  Future<List<Map<String, dynamic>>> getUserAnimals(String auth) async {
    http.Response response =
        await http.get(consts.getAnimalsUrl, headers: {'authorization': auth});
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  }

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
            onTap: () async {
              var animals = await getUserAnimals(auth);
              Navigator.of(context).pushNamed(
                '/user-account',
                arguments: {
                  'auth': auth,
                  'userInfo': userInfo,
                  'animals': animals,
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                '/settings',
                arguments: {
                  'userInfo': userInfo,
                  'auth': auth,
                },
              );
            },
          ),
          SizedBox(height: 150),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
        ],
      ),
    );
  }
}
