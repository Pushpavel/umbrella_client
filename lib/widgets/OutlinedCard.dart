import 'package:flutter/material.dart';

class OutlinedCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? outlineColor;
  final double? elevation;

  const OutlinedCard({Key? key, required this.child, this.color, this.outlineColor, this.elevation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = (Theme.of(context).cardTheme.shape as RoundedRectangleBorder);
    return Card(
      color: color,
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      shape: shape.copyWith(
        side: shape.side.copyWith(color: outlineColor),
      ),
      child: child,
    );
  }
}
