import 'package:flutbar/i3/core.dart';
import 'package:flutter/widgets.dart';

class I3Widget extends InheritedWidget {
  I3Widget({
    Key key,
    @required Widget child,
    this.i3Service,
  })  : assert(child != null),
        assert(i3Service != null),
        super(key: key, child: child);

  final I3Connection i3Service;

  static I3Widget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<I3Widget>();
  }

  @override
  bool updateShouldNotify(covariant I3Widget oldWidget) {
    return false;
  }
}
