import 'package:flutter/material.dart';
import 'package:umbrella_client/helpers/extensions/ColorExtensions.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle highEmphasis() => copyWith(color: color!.highEmphasis());

  TextStyle mediumEmphasis() => copyWith(color: color!.mediumEmphasis());

  TextStyle disabledEmphasis() => copyWith(color: color!.disabledEmphasis());
}
