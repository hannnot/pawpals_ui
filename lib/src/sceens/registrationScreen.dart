import 'dart:convert';
import 'dart:io';

import 'package:pawpals_ui/src/consts.dart' as consts;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String pwd;
  String firstname;
  String lastname;
  String phonenumber;

  final _form = GlobalKey<FormState>();

  void _saveForm() async {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      http.Response response = await http.post(consts.registerUrl,
          body: jsonEncode(<String, dynamic>{
            'firstname': firstname,
            'lastname': lastname,
            'email': email,
            'password': pwd,
            'phoneNumber': phonenumber
          }),
          headers: {'Content-Type': 'application/json;charset=UTF-8'});
      if (response.statusCode == HttpStatus.created) {
        http.Response regResponse = await http.post(consts.registerUrl,
            body:
                jsonEncode(<String, dynamic>{'email': email, 'password': pwd}),
            headers: {'Content-Type': 'application/json;charset=UTF-8'});

        if (regResponse.statusCode == HttpStatus.ok) {
          Navigator.of(context).pushReplacementNamed('/user-dashboard',
              arguments: {'auth': regResponse.headers['authorization']});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Registration')),
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
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Firstname',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Firstname';
                        } else {
                          setState(() {
                            firstname = value;
                          });
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Lastname',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Lastname';
                        } else {
                          setState(() {
                            lastname = value;
                          });
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phonenumber',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Phonenumber';
                        } else {
                          setState(() {
                            phonenumber = value;
                          });
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
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
                      onPressed: _saveForm,
                      child: Container(
                        width: 150,
                        child: Center(child: Text('Register')),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              FlatButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('/'),
                child: Container(
                  child: Text('Or LOGIN Now'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
