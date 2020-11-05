import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BrowseSitScreen extends StatefulWidget {
  @override
  _BrowseSitScreenState createState() => _BrowseSitScreenState();
}

class _BrowseSitScreenState extends State<BrowseSitScreen> {
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
    print(arguments);
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Sits'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: arguments['sits'] == ''
            ? Center(
                child: Container(
                child: Text('No sits available'),
              ))
            : ListView.builder(
                itemCount:
                    (arguments['sits'] as List<Map<String, dynamic>>).length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'Available Sit: ${arguments['sits'][index]['animal']['name']}',
                              textScaleFactor: 1.2,
                            ),
                          ),
                          Divider(),
                          Table(
                            children: [
                              TableRow(
                                children: [
                                  buildCells(true, 'Gender'),
                                  buildCells(
                                    false,
                                    arguments['sits'][index]['animal']['gender'],
                                  )
                                ],
                              ),
                              TableRow(
                                children: [
                                  buildCells(true, 'Breed'),
                                  buildCells(
                                    false,
                                    arguments['sits'][index]['animal']['breed'],
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  buildCells(true, 'Age'),
                                  buildCells(
                                    false,
                                    '${arguments['sits'][index]['animal']['age']}',
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  buildCells(true, 'Weight'),
                                  buildCells(
                                    false,
                                    '${arguments['sits'][index]['animal']['weight']}',
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  buildCells(true, 'Height'),
                                  buildCells(
                                    false,
                                    '${arguments['sits'][index]['animal']['height']}',
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  buildCells(true, 'Fears'),
                                  buildCells(
                                    false,
                                    arguments['sits'][index]['animal']['fears'],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                'About ${arguments['sits'][index]['animal']['name']} : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(arguments['sits'][index]['animal']['about']),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                'Activity you need to do: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(arguments['sits'][index]['activities']),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                'You will be sitting from: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  '${DateFormat('dd.MM.yy').format(DateTime.parse(arguments['sits'][index]['startDate']))} at ${DateFormat('hh:mm').format(DateTime.parse(arguments['sits'][index]['startDate']))}')
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                'To: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  '${DateFormat('dd.MM.yy').format(DateTime.parse(arguments['sits'][index]['endDate']))} at ${DateFormat('hh:mm').format(DateTime.parse(arguments['sits'][index]['endDate']))}')
                            ],
                          ),
                          Divider(),
                          FlatButton(
                            color: Colors.teal[200],
                            onPressed: () {},
                            child: Container(
                              height: 20,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Accept this sitting?',
                                  style: TextStyle(
                                    color: Colors.teal[800],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );

                  /* return Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.emoji_nature),
                          title: Text(
                              'Animals name: ${arguments['sits'][index]['animal']['name']}'),
                          subtitle: Text(
                              'Activity you have to do: ${arguments['sits'][index]['activities']}'),
                        trailing: Text('Age of Animal: ${arguments['sits'][index]['animal']['age']}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.watch_later_outlined),
                          title: Text('From: ${arguments['sits'][index]['']}'),
                        )
                      ],
                    ),
                  ); */
                  /* return ListTile(
              title: Text('Animals name: ${arguments['sits'][index]['animal']['name']}'),

            ); */
                },
              ),
      ),
    );
  }
}
