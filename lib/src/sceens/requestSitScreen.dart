import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pawpals_ui/src/consts.dart' as consts;

class RequestSitScreen extends StatefulWidget {
  @override
  _RequestSitScreenState createState() => _RequestSitScreenState();
}

class _RequestSitScreenState extends State<RequestSitScreen> {
  DateTime selectedStartDate;
  DateTime selectedEndDate;
  TimeOfDay selectedStartTime;
  TimeOfDay selectedEndTime;

  DateTime startDateTime;
  DateTime endDateTime;
  Map<String, dynamic> animal;
  String activeActivity = 'Walk';
  int dropDownValue;
  List<String> activity = [
    'Walk',
    'Feed',
    'Brush',
  ];

  Future<void> _selectStartDate() async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 1)),
            lastDate: DateTime(2022))
        .then((date) {
      selectedStartDate = date;
    }).then((_) async {
      await showTimePicker(context: context, initialTime: TimeOfDay.now())
          .then((time) {
        selectedStartTime = time;
      });
    });

    final combined = DateTime(
      selectedStartDate.year,
      selectedStartDate.month,
      selectedStartDate.day,
      selectedStartTime.hour,
      selectedStartTime.minute,
    );
    print(combined);
    setState(() {
      startDateTime = combined;
      print(startDateTime);
    });
  }

  Future<void> _selectEndDate() async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 1)),
            lastDate: DateTime(2022))
        .then((date) {
      selectedEndDate = date;
    }).then((_) async {
      await showTimePicker(context: context, initialTime: TimeOfDay.now())
          .then((time) {
        selectedEndTime = time;
      });
    });
    final combined = DateTime(
      selectedEndDate.year,
      selectedEndDate.month,
      selectedEndDate.day,
      selectedEndTime.hour,
      selectedEndTime.minute,
    );
    setState(() {
      endDateTime = combined;
      print(endDateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Sit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: arguments['userAnimals'] == null
              ? Center(
                  child: Text(
                      'To request a sit you must at least have one animal added'),
                )
              : Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.emoji_nature),
                      title: animal == null
                          ? Text('Select your animal')
                          : Text(animal['animal']['name']),
                      subtitle: animal == null
                          ? Text('')
                          : Text(animal['animal']['breed']),
                      trailing: animal == null
                          ? Text('')
                          : Text('Age: ${animal['animal']['age']}'),
                      onTap: () async {
                        var animals = await Navigator.of(context).pushNamed(
                          '/select-animal',
                          arguments: {'userAnimals': arguments['userAnimals']},
                        );
                        setState(() {
                          animal = animals;
                        });
                      },
                    ),
                    Container(
                      color: Colors.teal[200],
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Select start and end date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    ListTile(
                      onTap: () async {
                        await _selectStartDate();
                        setState(() {});
                      },
                      leading: Icon(
                        Icons.calendar_today,
                        color: Colors.teal,
                      ),
                      title: startDateTime != null
                          ? Text(
                              'From ${DateFormat('d MMMM y').format(startDateTime)} at ${DateFormat('hh:mm').format(startDateTime)}')
                          : Text('Please select start time'),
                    ),
                    ListTile(
                      onTap: () async {
                        await _selectEndDate();
                        setState(() {});
                      },
                      leading: Icon(
                        Icons.date_range_outlined,
                        color: Colors.teal,
                      ),
                      title: endDateTime != null
                          ? Text(
                              'To ${DateFormat('d MMMM y').format(endDateTime)} at ${DateFormat('hh:mm').format(endDateTime)}')
                          : Text('Please select end time'),
                    ),
                    SizedBox(height: 30),
                    Container(
                      color: Colors.teal[200],
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Select activity',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 170,
                      child: ListView.builder(
                          itemCount: activity.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                RadioListTile(
                                  onChanged: (value) {
                                    setState(() {
                                      activeActivity = value;
                                    });
                                  },
                                  groupValue: activeActivity,
                                  value: activity[index],
                                  title: Text(activity[index]),
                                )
                              ],
                            );
                          }),
                    ),
                    SizedBox(height: 30),
                    FlatButton(
                      hoverColor: Colors.teal[100],
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () async {
                        Map<String, dynamic> body = {
                          'startDate': startDateTime.toIso8601String(),
                          'endDate': endDateTime.toIso8601String(),
                          'activities': activeActivity,
                          'animal': {
                            'name': animal['animal']['name'],
                            'age': animal['animal']['age'],
                            'gender': animal['animal']['gender'],
                            'breed': animal['animal']['breed'],
                            'weight': animal['animal']['weight'],
                            'height': animal['animal']['height'],
                            'fears': animal['animal']['fears'],
                            'about': animal['animal']['about']
                          },
                        };

                        http.Response response = await http.post(
                          consts.requestSitUrl,
                          body: jsonEncode(body),
                          headers: {
                            'authorization': arguments['auth'],
                            'Content-Type': 'application/json;charset=UTF-8'
                          },
                        );
                        print(response.statusCode);
                        print(response.body);
                        if (response.statusCode == HttpStatus.created) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        width: 150,
                        child: Center(
                            child: Text(
                          'Request Sit',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
