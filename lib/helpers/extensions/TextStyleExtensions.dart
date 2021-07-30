import 'package:flutter/cupertino.dart';

extension TextStyleExtensions on TextStyle {
  highEmphasis() {
    return copyWith(
      color: color!.withOpacity(0.87),
    );
  }

  mediumEmphasis() {
    return copyWith(
      color: color!.withOpacity(0.60),
    );
  }

  disabledText() {
    return copyWith(
      color: color!.withOpacity(0.38),
    );
  }
}
