import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class ChangePassworScreen extends StatefulWidget {
  @override
  _ChangePassworScreenState createState() => _ChangePassworScreenState();
}

class _ChangePassworScreenState extends State<ChangePassworScreen> {
  var cookie;
  final _formkey = GlobalKey<FormState>();
  String _pwdOld;
  String _pwdNew;
  String _pwdNewRepeat;

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  _changePWD(String auth) async {
    final form = _formkey.currentState;
    form.save();
    if (form.validate()) {
      http.Response response = await http.post('', //Change PWD endpoint needed
          body: {
            "oldPwd": _pwdOld,
            "newPwd": _pwdNew
          }, headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'authorization': auth,
      });

      if (response.statusCode == HttpStatus.ok) {
        if (response.headers['authorization'] != '') {
          var token = response.headers['authorization'].split(' ')[1];
          Map<String, dynamic> decodedUser = JwtDecoder.decode(token);

          if ((decodedUser['roles'] as List).contains('ADMIN')) {
            Navigator.of(context).pushReplacementNamed('/admin-dashboard',
                arguments: {
                  'auth': response.headers['authorization'],
                  'userInfo': decodedUser
                });
          } else {
            Navigator.of(context).pushReplacementNamed('/user-dashboard',
                arguments: {
                  'auth': response.headers['authorization'],
                  'userInfo': decodedUser
                });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Image(
                    image: AssetImage('assets/images/fair-rates-logo.png')))),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Form(
              child: Column(
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: "Old passoword",
                                fillColor: Colors.white),
                            onSaved: (newValue) {
                              setState(() {
                                _pwdOld = newValue;
                              });
                            }),
                        TextFormField(
                          validator: (value) {
                            if (value == _pwdOld) {
                              return 'Please enter a new password';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "New password",
                              fillColor: Colors.white),
                          onSaved: (newValue) {
                            setState(() {
                              _pwdNew = newValue;
                            });
                          },
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != _pwdNew) {
                              return 'Passwords ar not matching';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "Repeat new password ",
                              fillColor: Colors.white),
                          onSaved: (newValue) {
                            setState(() {
                              _pwdNewRepeat = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                            color: Color.fromRGBO(56, 69, 81, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.white)),
                            child: Container(
                              width: 200,
                              child: Center(
                                child: Text(
                                  "Change password",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              await _changePWD(arguments['auth']);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
