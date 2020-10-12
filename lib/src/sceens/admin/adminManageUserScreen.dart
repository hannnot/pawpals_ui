import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pawpals_ui/src/consts.dart' as consts;
import 'package:pawpals_ui/src/widgets/adminDrawer.dart';

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
      drawer: AdminDrawer(
        auth: arguments['auth'],
        userInfo: arguments['userInfo'],
      ),
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: (arguments['users'] as List).length,
          itemBuilder: (context, index) {
            return ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(arguments['users'][index]['email']),
                trailing: Switch(
                  activeColor: Colors.green,
                  inactiveTrackColor: Colors.red,
                  value: arguments['users'][index]['deactivatedAt'] == null
                      ? true
                      : false,
                  onChanged: (bool newValue) async {
                    if (arguments['users'][index]['deactivatedAt'] == null) {
                      http.Response response = await http.post(
                        consts.deactivateUserUrl +
                            '${arguments['users'][index]['id']}',
                        headers: {
                          'authorization': arguments['auth'],
                          'Content-Type': 'application/json;charset=UTF-8'
                        },
                      );
                      if (response.statusCode == HttpStatus.ok) {
                        setState(() {
                          newValue = false;
                        });
                      }
                    }else {
                      http.Response response = await http.post(
                        consts.deactivateUserUrl +
                            '${arguments['users'][index]['id']}',
                        headers: {
                          'authorization': arguments['auth'],
                          'Content-Type': 'application/json;charset=UTF-8'
                        },
                      );
                      if (response.statusCode == HttpStatus.ok) {
                        setState(() {
                          newValue = true;
                        });
                      }
                    }
                  },
                ) /* IconButton(
                icon: Icon(Icons.delete_forever, color: Colors.red,),
                onPressed: () async {
                  http.Response response = await http.post(
                    consts.deactivateUserUrl + '${arguments['users'][index]['id']}',
                    headers: {
                      'authorization': arguments['auth'],
                      'Content-Type': 'application/json;charset=UTF-8'
                    },
                  );
                  if(response.statusCode == HttpStatus.ok){
                    setState(() {
                      (arguments['users'] as List).removeAt(index);
                    });
                  }
                  print(response.statusCode);

                },
              ), */
                );
          },
        ),
      ),
    );
  }
}
