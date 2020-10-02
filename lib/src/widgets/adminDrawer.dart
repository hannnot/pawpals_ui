import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pawpals_ui/src/consts.dart' as consts;

class AdminDrawer extends StatelessWidget {

  final token;

  AdminDrawer({@required this.token});

  Future<List<Map<String, dynamic>>> getUsers()async{
    http.Response response = await http.get(consts.accountOverview, headers: {'authorization': token});
    return List<Map<String,dynamic>>.from(json.decode(response.body));
  }
  
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
            leading: Icon(Icons.supervisor_account),
            title: Text('Manage users'),
            onTap: () async {
              var users = await getUsers();
              users.forEach((element) {print(element);});
              // TODO create manage user screen
              Navigator.of(context).pushNamed('/manage-users', arguments: {'auth': token, 'users': users});
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {

              // TODO make networkrequest to logout
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}