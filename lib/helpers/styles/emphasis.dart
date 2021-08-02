import 'package:flutter/material.dart';
import 'package:umbrella_client/helpers/extensions/TextStyleExtensions.dart';

class HighEmphasis extends StatelessWidget {
  final Widget child;

  const HighEmphasis({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(context).style.highEmphasis(),
      child: child,
    );
  }
}
