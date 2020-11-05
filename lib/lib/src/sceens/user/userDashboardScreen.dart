import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/userDrawer.dart';
import 'package:pawpals_ui/src/consts.dart' as consts;
import 'package:http/http.dart' as http;

class UserDashboardScreen extends StatefulWidget {
  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  Future<List<Map<String, dynamic>>> getAllSits(String auth) async {
    http.Response response =
        await http.get(consts.browseSitsUrl, headers: {'authorization': auth});
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  }

  Future<List<Map<String, dynamic>>> getAnimals(String auth) async {
    http.Response response =
        await http.get(consts.getAnimalsUrl, headers: {'authorization': auth});
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      drawer: UserDrawer(
        auth: arguments['auth'],
        userInfo: arguments['userInfo'],
      ),
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: CircleAvatar(radius: 40)),
              SizedBox(height: 10),
              Center(child: Text(arguments['userInfo']['firstname'])),
              SizedBox(height: 50),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () async {
                  List<Map<String, dynamic>> sits =
                      await getAllSits(arguments['auth']);
                  Navigator.of(context).pushNamed(
                    '/browse-sit',
                    arguments: {
                      'auth': arguments['auth'],
                      'userInfo': arguments['userInfo'],
                      'sits': sits,
                    },
                  );
                },
                child: Container(
                  width: 150,
                  child: Center(child: Text('Browse Sits')),
                ),
                color: Colors.teal[200],
              ),
              SizedBox(height: 15),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () async {
                  var animals = await getAnimals(arguments['auth']);
                  Navigator.of(context).pushNamed(
                    '/request-sit',
                    arguments: {
                      'auth': arguments['auth'],
                      'userInfo': arguments['userInfo'],
                      'userAnimals': animals,
                    },
                  );
                },
                child: Container(
                  width: 150,
                  child: Center(child: Text('Request Sit')),
                ),
                color: Colors.teal[200],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
