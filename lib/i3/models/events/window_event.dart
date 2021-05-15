import 'package:flutbar/i3/models/common/node.dart';

class WindowEvent {
  String change;
  Node container;

  WindowEvent({this.change, this.container});

  WindowEvent.fromJson(Map<String, dynamic> json) {
    change = json['change'];
    container =
        json['container'] != null ? new Node.fromJson(json['container']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['change'] = this.change;
    if (this.container != null) {
      data['container'] = this.container.toJson();
    }
    return data;
  }
}
