import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/adminDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pawpals_ui/src/consts.dart' as consts;

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {

   Future<List<Map<String,dynamic>>> getAllSits(String auth) async {
    http.Response response =
        await http.get(consts.browseSitsUrl, headers: {'Authorization': auth}); 
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  }

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
        title: Text('Welcome'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(child: CircleAvatar(radius: 50)),
              SizedBox(height: 20),
              Center(
                child: Text(arguments['userInfo']['firstname'],
                    style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 50),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () async{
                  List<Map<String,dynamic>> sits = await getAllSits(arguments['auth']);
                  Navigator.of(context).pushNamed('/browse-sit', arguments: {
                    'auth': arguments['auth'],
                    'userInfo': arguments['userInfo'],
                    'sits': sits,
                  });
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
                onPressed: () {
                  Navigator.of(context).pushNamed('/request-sit', arguments: {
                    'auth': arguments['auth'],
                    'userInfo': arguments['userInfo'],
                  });
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
