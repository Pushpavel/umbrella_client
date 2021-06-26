import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedStandCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("NITPY Boys Hostel", style: theme.textTheme.headline6),
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
              ),
              Icon(Icons.unfold_more),
            ],
          ),
        ),
        onTap: () => {},
      ),
    );
  }
}
