import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminDrawer extends StatelessWidget {

  final token;

  AdminDrawer({@required this.token});

  Future<List<Map<String, dynamic>>> getUsers()async{
    //TODO make get all user request
    http.Response response = await http.get('url', headers: {'authorization': token});
    var users = List<Map<String, dynamic>>.from(response.body as List<Map<String,dynamic>>);
    return users;
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