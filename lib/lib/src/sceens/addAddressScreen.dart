import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  String street;
  String state;
  String city;
  int zip;

  final _form = GlobalKey<FormState>();

  void _saveForm(Map<String, dynamic> userinfo) {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      Navigator.of(context).pushNamed('/about', arguments: {
        'userinfo': userinfo,
        'useraddress': {
          'street': street,
          'state': state,
          'city': city,
          'zip': zip,
        }
      });
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
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    labelText: 'Street/ Nr.',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your street and house number';
                    } else {
                      setState(() {
                        street = value;
                      });
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'State',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your State';
                    } else {
                      setState(() {
                        state = value;
                      });
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'City',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your city';
                    } else {
                      setState(() {
                        city = value;
                      });
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'ZIP',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your ZIP code';
                    } else {
                      setState(() {
                        zip = int.parse(value);
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
                    _saveForm(arguments['userinfo']);
                  },
                  child: Container(
                    width: 150,
                    child: Center(child: Text('NEXT')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
