import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/widgets/userDrawer.dart';

class UserAccountScreen extends StatelessWidget {
  Widget buildCells(bool isLable, String text) {
    return TableCell(
      child: Text(
        text,
        style: TextStyle(
            fontSize: 17,
            fontWeight: isLable ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal[200],
        label: Text(
          'Add an animal',
          style: TextStyle(color: Colors.teal[800]),
        ),
        onPressed: () => Navigator.of(context).pushNamed(
          '/add-animals',
          arguments: {
            'auth': arguments['auth'],
            'userInfo': arguments['userInfo']
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: UserDrawer(
        auth: arguments['auth'],
        userInfo: arguments['userInfo'],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Center(
                        child:
                            Text('Personal information', textScaleFactor: 1.2),
                      ),
                      Divider(),
                      Table(
                        children: [
                          TableRow(
                            children: [
                              buildCells(true, 'Fristname'),
                              buildCells(
                                  false, arguments['userInfo']['firstname'])
                            ],
                          ),
                          TableRow(
                            children: [
                              buildCells(true, 'Lastname'),
                              buildCells(
                                  false, arguments['userInfo']['lastname']),
                            ],
                          ),
                          TableRow(
                            children: [
                              buildCells(true, 'Email'),
                              buildCells(false, arguments['userInfo']['email']),
                            ],
                          ),
                          TableRow(
                            children: [
                              buildCells(true, 'Phonenumber'),
                              buildCells(
                                  false, arguments['userInfo']['phoneNumber']),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Center(
                        child: Text('Your address', textScaleFactor: 1.2),
                      ),
                      Divider(),
                      Table(
                        children: [
                          TableRow(
                            children: [
                              buildCells(true, 'Street'),
                              buildCells(false,
                                  arguments['userInfo']['address']['street'])
                            ],
                          ),
                          TableRow(
                            children: [
                              buildCells(true, 'State'),
                              buildCells(false,
                                  arguments['userInfo']['address']['state']),
                            ],
                          ),
                          TableRow(
                            children: [
                              buildCells(true, 'City'),
                              buildCells(false,
                                  arguments['userInfo']['address']['city']),
                            ],
                          ),
                          TableRow(
                            children: [
                              buildCells(true, 'ZIP'),
                              buildCells(false,
                                  arguments['userInfo']['address']['zip']),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text('About you', textScaleFactor: 1.2),
                      Divider(),
                      Text(arguments['userInfo']['about'])
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Your Animals',
                textScaleFactor: 1.2,
              ),
              Divider(),
              arguments['animals'] == null
                  ? Container()
                  : Card(
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        child: ListView.builder(
                          itemCount: (arguments['animals']
                                  as List<Map<String, dynamic>>)
                              .length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              title: Text(
                                  'Name: ${arguments['animals'][index]['name']}'),
                              subtitle: Text(
                                  'Breed: ${arguments['animals'][index]['breed']}'),
                              trailing: Text(
                                  'Age: ${arguments['animals'][index]['age']}'),
                            );
                          },
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
