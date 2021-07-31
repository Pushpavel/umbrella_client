import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:umbrella_client/resources/Strings.dart';
import 'package:umbrella_client/widgets/OutlinedCard.dart';

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
                  child: _PickupCard(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PickupCard extends StatelessWidget {
  const _PickupCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      color: Theme.of(context).primaryColor,
      outlineColor: Theme.of(context).primaryColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              "Pickup the Umbrella",
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
            Wrap(
              children: [
                Icon(Icons.place),
                Text("data"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
