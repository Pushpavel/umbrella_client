import 'package:flutter/material.dart';
import 'package:umbrella_client/data/models/Stand.dart';

class StandContent extends StatelessWidget {
  final Stand stand;

  const StandContent(this.stand);

  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(stand.name, style: theme.textTheme.headline6),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 2,
          children: [
            Icon(Icons.straighten, color: Colors.grey),
            Text("588m", style: theme.textTheme.caption),
          ],
        ),
        SizedBox(height: 8),
        OutlinedButton.icon(
          icon: Icon(Icons.navigation),
          label: Text("DIRECTIONS", style: theme.textTheme.button),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Not Yet Implemented"),
              ),
            );
          },
        ),
      ],
    );
  }
}
