import 'dart:io';

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
      //TODO make network request to validate input WITH VALID url
      http.Response response = await http.post('', body: {
        'email' : email,
        'pwd': pwd
      });
      if(response.statusCode == HttpStatus.accepted){
        //TODO create dashboard screen
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
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
                      }else {
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
                      }else {
                        setState(() {
                          pwd = value;
                        });
                        return null;
                      }
                    }
                  ),
                  SizedBox(height: 10),
                  FlatButton(
                    onPressed: _saveForm, //TODO make request to API to proccede
                    child: Container(
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            FlatButton(
              onPressed: null, //TODO Navigate to registration screen
              child: Container(
                child: Text('Or register Now'),
              ),
            )
          ],
        ),
      ),
    );
  }
}