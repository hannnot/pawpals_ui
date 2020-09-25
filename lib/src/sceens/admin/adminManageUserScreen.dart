import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pawpals_ui/src/consts.dart' as consts;

class AdminManageUserScreen extends StatefulWidget {
  @override
  _AdminManageUserScreenState createState() => _AdminManageUserScreenState();
}

class _AdminManageUserScreenState extends State<AdminManageUserScreen> {
  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.account_circle),
          title: Text(arguments['users'][index]['email']),
          trailing: IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              http.Response response = await http.post(
                  consts.deactivateAccount +
                      '${arguments['users'][index]['userid']}',
                  headers: {
                    'authorization': arguments['users'][index]['auth']
                  });
            },
          ),
        );
      }),
    );
  }
}
