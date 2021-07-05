import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/widgets/SelectedStandCard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final selectedStandId$ = BehaviorSubject<String>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SelectedStandCard(
            selectedStandId$: selectedStandId$,
          ),
          Container(
            padding: EdgeInsets.all(32),
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              icon: Icon(Icons.umbrella),
              label: Text("REQUEST UMBRELLA"),
              onPressed: () {
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    selectedStandId$.close();
    super.dispose();
  }
}
