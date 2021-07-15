import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';

class ErrorScreen extends StatelessWidget {
  final Err err;

  const ErrorScreen({Key? key, required this.err}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Oops!",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            Text(
              err.message,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            Text(err.stackTrace.toString()),
          ],
        ),
      ),
    );
  }
}
