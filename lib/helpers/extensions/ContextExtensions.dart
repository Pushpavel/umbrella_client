import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

extension contexte on BuildContext {
  T get<T>([bool listen = true]) => Provider.of(this, listen: listen);
}
