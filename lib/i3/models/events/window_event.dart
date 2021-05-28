import 'package:flutbar/i3/models/common/node.dart';

class WindowEvent {
  String change;
  Node container;

  WindowEvent({required this.change, required this.container});

  WindowEvent.fromJson(Map<String, dynamic> json)
      : change = json['change'],
        container = Node.fromJson(json['container']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['change'] = this.change;
    if (this.container != null) {
      data['container'] = this.container.toJson();
    }
    return data;
  }

  @override
  String toString() => "Window Event -> change: $change";
}

class WindowChangeType {
  static const String NEW = 'new';
  static const String CLOSE = 'close';
  static const String FOCUS = 'focus';
  static const String TITLE = 'title';
  static const String FULLSCREEN_MODE = 'fullscreen_mode';
  static const String MOVE = 'move';
  static const String FLOATING = 'floating';
  static const String URGENT = 'urgent';
  static const String MARK = 'mark';
}
