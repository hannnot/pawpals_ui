import 'dart:convert';
import 'dart:io';
import 'package:pawpals_ui/src/consts.dart' as consts;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email;
  String pwd;

  final _form = GlobalKey<FormState>();

  void _saveForm() async {
    if (_form.currentState.validate()) {
      _form.currentState.save();

      http.Response response = await http.post(consts.loginUrl,
          body: jsonEncode(<String, dynamic>{'email': email, 'password': pwd}),
          headers: {'Content-Type': 'application/json;charset=UTF-8'});

      if (response.statusCode == HttpStatus.accepted) {
        var body = jsonDecode(response.body);
        //TODO check wether user is admin or normal user
        Navigator.of(context).pushReplacementNamed('/user-dashboard',
            arguments: {'auth': body['token']});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image(image: AssetImage('assets/images/pawPalsLogo.png')),
              SizedBox(height: 25),
              Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        } else {
                          setState(() {
                            email = value;
                          });
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter password';
                          } else {
                            setState(() {
                              pwd = value;
                            });
                            return null;
                          }
                        }),
                    SizedBox(height: 30),
                    FlatButton(
                      hoverColor: Colors.teal[100],
                      color: Colors.teal[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed:
                          _saveForm /* () => Navigator.of(context)
                          .pushReplacementNamed('/user-dashboard') */
                      ,
                      child: Container(
                        width: 150,
                        child: Center(child: Text('Login')),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              FlatButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('/register'),
                child: Container(
                  child: Text('Or REGISTER Now'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
