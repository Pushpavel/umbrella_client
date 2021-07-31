import 'package:flutter/material.dart';

class OutlinedCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? outlineColor;
  final double? elevation;
  final EdgeInsets? margin;

  const OutlinedCard({
    Key? key,
    required this.child,
    this.color,
    this.outlineColor,
    this.elevation,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = (Theme.of(context).cardTheme.shape as RoundedRectangleBorder);
    return Card(
      color: color,
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      margin: margin,
      shape: shape.copyWith(
        side: shape.side.copyWith(color: outlineColor),
      ),
      child: child,
    );
  }
}
