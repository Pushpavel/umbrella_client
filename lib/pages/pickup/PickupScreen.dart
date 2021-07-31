import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umbrella_client/pages/pickup/PickupCard.dart';
import 'package:umbrella_client/resources/Strings.dart';

class PickupScreen extends StatelessWidget {
  const PickupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.topLeft,
              child: BackButton(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      Strings.pickupInstructionsTitle,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 16),
                    Text(
                      Strings.pickupInstructionsBody,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 2),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PickupCard(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
