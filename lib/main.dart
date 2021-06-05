import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Select Stand to Choose Umbrella:';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Umbrella For You',
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(child: MyStatefulWidget()
        ),
        ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'One';
  Widget buildDropDownButton(){
  return Container(
      alignment: Alignment.center,
      color: Colors.lightBlue,
      child:  DropdownButton<String>(
        value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_circle),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      
      },
      items: <String>['One', 'Two', 'Three', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),

        );
      }).toList(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
      color: Colors.lightBlue,
      child:  DropdownButton<String>(
        value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_circle),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      
      },
      items: <String>['One', 'Two', 'Three', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),

        );
      }).toList(),
      ),
    ),
    backgroundColor: Color(0xffff40ff),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
        onPressed: () =>showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Umbrella'),
          content: const Text('Request Granted'),
        ),
        ),
    ),
    );
    
    
  }

}


