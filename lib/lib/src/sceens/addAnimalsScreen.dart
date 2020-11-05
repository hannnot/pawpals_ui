import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:io';
import 'package:pawpals_ui/src/consts.dart' as consts;

class AddAnimalsScreen extends StatefulWidget {
  @override
  _AddAnimalsScreenState createState() => _AddAnimalsScreenState();
}

class _AddAnimalsScreenState extends State<AddAnimalsScreen> {
  final _form = GlobalKey<FormState>();

  String name;
  int age;
  String gender;
  String breed;
  int weight;
  int height;
  String fears;
  String about;

  void _saveForm(Map<String, dynamic> arguments) async {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      http.Response response = await http.post(consts.addAnimalUrl,
          body: jsonEncode(<String, dynamic>{
            'name': name,
            'age': age,
            'gender': gender,
            'breed': breed,
            'weight': weight,
            'height': height,
            'fears': fears,
            'about': about
          }),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'authorization': arguments['auth'],
          });
      print(response.statusCode);
      Navigator.of(context).pop();
    }
  }

  void _saveFormToRegister(Map<String, dynamic> arguments) async {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      http.Response response = await http.post(consts.registerUrl,
          body: jsonEncode(<String, dynamic>{
            'firstname': arguments['userinfo']['firstname'],
            'lastname': arguments['userinfo']['lastname'],
            'email': arguments['userinfo']['email'],
            'password': arguments['userinfo']['password'],
            'phoneNumber': arguments['userinfo']['phoneNumber'],
            'about': arguments['about'],
            'animals': [
              {
                'name': name,
                'age': age,
                'gender': gender,
                'breed': breed,
                'weight': weight,
                'height': height,
                'fears': fears,
                'about': about
              }
            ],
            'address': {
              'street': arguments['useraddress']['street'],
              'state': arguments['useraddress']['state'],
              'city': arguments['useraddress']['city'],
              'zip': arguments['useraddress']['zip'],
            },
          }),
          headers: {'Content-Type': 'application/json;charset=UTF-8'});
      print(response.statusCode);
      if (response.statusCode == HttpStatus.created) {
        http.Response regResponse = await http.post(consts.loginUrl,
            body: jsonEncode(<String, dynamic>{
              'email': arguments['userinfo']['email'],
              'password': arguments['userinfo']['password']
            }),
            headers: {'Content-Type': 'application/json;charset=UTF-8'});
        if (regResponse.statusCode == HttpStatus.ok) {
          if (regResponse.headers['authorization'] != '') {
            var token = regResponse.headers['authorization'].split(' ')[1];
            Map<String, dynamic> decodedUser = JwtDecoder.decode(token);
            http.Response userResponse = await http
                .get(consts.getUserByEmailUrl + decodedUser['email'], headers: {
              'Content-Type': 'application/json;charset=UTF-8',
              'authorization': regResponse.headers['authorization']
            });
            print(regResponse.statusCode);
            if (userResponse.statusCode == HttpStatus.ok) {
              var userinfo =
                  Map<String, dynamic>.from(json.decode(userResponse.body));
              Navigator.of(context)
                  .pushReplacementNamed('/user-dashboard', arguments: {
                'auth': response.headers['authorization'],
                'userInfo': userinfo,
              });
            }
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
        title: Text('Add your animal'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 25),
              Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Name of your Animal',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your animals name';
                        } else {
                          setState(() {
                            name = value;
                          });
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age of your Animal',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your animals age';
                        } else {
                          setState(() {
                            age = int.parse(value);
                          });
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Gender of your Animal',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your animals gender';
                        } else {
                          setState(() {
                            gender = value;
                          });
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Breed of your Animal',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your animals breed';
                        } else {
                          setState(() {
                            breed = value;
                          });
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Weight of your Animal',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your animals weight';
                          } else {
                            setState(() {
                              weight = int.parse(value);
                            });
                            return null;
                          }
                        }),
                    SizedBox(height: 10),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Height of your Animal',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your animals heigt';
                          } else {
                            setState(() {
                              height = int.parse(value);
                            });
                            return null;
                          }
                        }),
                    SizedBox(height: 10),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Fears of your Animal',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your animals fears';
                          } else {
                            setState(() {
                              fears = value;
                            });
                            return null;
                          }
                        }),
                    SizedBox(height: 10),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Tell us more of your Animal',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter at least one word :)';
                          } else {
                            setState(() {
                              about = value;
                            });
                            return null;
                          }
                        }),
                    SizedBox(height: 30),
                    FlatButton(
                      hoverColor: Colors.teal[100],
                      color: Colors.teal[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        arguments['auth'] == null
                            ? _saveFormToRegister(arguments)
                            : _saveForm(arguments);
                      },
                      child: Container(
                        width: 150,
                        child: Center(
                            child: arguments['auth'] == null
                                ? Text('REGISTER')
                                : Text('Add animal')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
