import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrimaryButton extends StatelessWidget {
  final Widget label;
  final Widget? trailing;
  final Function() onPressed;

  const PrimaryButton({Key? key, required this.label, required this.onPressed, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Theme.of(context).primaryColor,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.button!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        child: IconTheme.merge(
          data: Theme.of(context).iconTheme.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  label,
                  if (trailing != null) ...[
                    SizedBox(width: 8),
                    trailing!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
