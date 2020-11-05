import 'package:flutter/material.dart';

class SelectAnimalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Animal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount:
              (arguments['userAnimals'] as List<Map<String, dynamic>>).length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: Text('Age: ${arguments['userAnimals'][index]['age']}'),
              subtitle: Text(arguments['userAnimals'][index]['breed']),
              title: Text(arguments['userAnimals'][index]['name']),
              onTap: (){
                Navigator.of(context).pop({'animal': arguments['userAnimals'][index]});
              },
            );
          },
        ),
      ),
    );
  }
}
