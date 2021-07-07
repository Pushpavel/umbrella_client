import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NavUtils on BuildContext {
  Future<T?> resetNavStackWith<T extends Object?>(Widget screen) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }
}
