import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/userDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:pawpals_ui/src/consts.dart' as consts;

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: UserDrawer(
        auth: null,
        userInfo: null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SwitchListTile(
                title: Text('Deactivate/ activate account'),
                value: arguments['userInfo']['deactivatedAt'] == null
                    ? true
                    : false,
                onChanged: (bool newValue) async {
                  if (arguments['userInfo']['deactivatedAt'] == null) {
                    var consts;
                    http.Response response = await http.post(
                      consts.deactivateUserUrl +
                          '${arguments['userInfo']['id']}',
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
                  } else {
                    http.Response response = await http.post(
                      consts.deactivateUserUrl +
                          '${arguments['userInfo']['id']}',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
