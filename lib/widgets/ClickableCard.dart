import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  final Widget? child;
  final Function()? onClick;

  const ClickableCard({Key? key, this.onClick, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: child,
        ),
        onTap: onClick,
      ),
    );
  }
}
