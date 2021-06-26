import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class PickupScreen extends StatefulWidget {
  const PickupScreen({Key? key}) : super(key: key);

  @override
  State<PickupScreen> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<PickupScreen> {
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

