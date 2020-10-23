import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String activeActivity = 'Walk';

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
      print('test');
      print(selectedStartDate);
    }).then((_) async {
      await showTimePicker(context: context, initialTime: TimeOfDay.now())
          .then((time) {
        selectedStartTime = time;
        print('test1');
        print(selectedStartTime);
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
      print('test2');
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
    //return startDateTime;
    setState(() {
      startDateTime = combined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Sit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
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
                      onPressed: (){}, //TODO make network request to request sit, pop site
                      child: Container(
                        width: 150,
                        child: Center(child: Text('Request Sit', style: TextStyle(color: Colors.white),)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
