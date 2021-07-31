import 'package:flutter/material.dart';
import 'package:umbrella_client/helpers/extensions/ColorExtensions.dart';
import 'package:umbrella_client/widgets/OutlinedCard.dart';

class PickupCard extends StatelessWidget {
  final EdgeInsets? margin;

  const PickupCard({Key? key, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      color: Theme.of(context).colorScheme.primary,
      outlineColor: Theme.of(context).colorScheme.primary,
      margin: margin,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              "Pickup the Umbrella",
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
            SizedBox(height: 24),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.place,
                  color: Theme.of(context).colorScheme.onPrimary.mediumEmphasis(),
                ),
                const SizedBox(width: 8),
                Text(
                  "Boys Hostel, NIT-PY",
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: Theme.of(context).colorScheme.secondary,
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                "60",
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
