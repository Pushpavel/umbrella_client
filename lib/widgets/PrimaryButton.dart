import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrimaryButton extends StatelessWidget {
  final Widget label;
  final Widget? trailing;
  final Function() onPressed;
  final bool disabled;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.trailing,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget content = Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [
          label,
          if (trailing != null) trailing!,
        ],
      ),
    );

    if (!disabled)
      content = InkWell(
        splashFactory: InkRipple.splashFactory,
        onTap: onPressed,
        child: content,
      );

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: disabled ? theme.disabledColor : theme.primaryColor,
      child: DefaultTextStyle(
        style: theme.primaryTextTheme.button!,
        child: IconTheme.merge(
          data: theme.primaryIconTheme,
          child: content,
        ),
      ),
    );
  }
}
