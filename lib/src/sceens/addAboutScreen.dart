import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pawpals_ui/src/consts.dart' as consts;

class AddAboutScreen extends StatefulWidget {
  @override
  _AddAboutScreenState createState() => _AddAboutScreenState();
}

class _AddAboutScreenState extends State<AddAboutScreen> {
  final _form = GlobalKey<FormState>();
  String about;

  void _saveForm(Map<String, dynamic> arguments) async {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      http.Response response = await http.post(consts.registerUrl,
          body: jsonEncode(<String, dynamic>{
            'firstname': arguments['userinfo']['firstname'],
            'lastname': arguments['userinfo']['lastname'],
            'email': arguments['userinfo']['email'],
            'password': arguments['userinfo']['password'],
            'phoneNumber': arguments['userinfo']['phoneNumber'],
            'about': about,
            'animals': [],
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
        title: Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Tell us something about yout',
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
                    },
                  ),
                  SizedBox(height: 30),
                  FlatButton(
                    hoverColor: Colors.teal[100],
                    color: Colors.teal[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      if (_form.currentState.validate()) {
                        _form.currentState.save();
                        Navigator.of(context).pushNamed('/add-animals', arguments: {
                          'userinfo': arguments['userinfo'],
                          'useraddress': arguments['useraddress'],
                          'about': about
                        });
                      }
                    },
                    child: Container(
                      width: 150,
                      child: Center(child: Text('Add Animals')),
                    ),
                  ),
                  FlatButton(
                    hoverColor: Colors.teal[100],
                    color: Colors.teal[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      _saveForm(arguments);
                    },
                    child: Container(
                      width: 150,
                      child: Center(child: Text('Not now just REGISTER')),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
