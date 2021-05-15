import 'package:flutbar/i3/models/common/node.dart';

class WorspaceEvent {
  String change;
  Node current;
  Node old;

  WorspaceEvent({this.change, this.current, this.old});

  WorspaceEvent.fromJson(Map<String, dynamic> json) {
    change = json['change'];
    current =
        json['current'] != null ? new Node.fromJson(json['current']) : null;
    old = json['old'] != null ? new Node.fromJson(json['old']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['change'] = this.change;
    if (this.current != null) {
      data['current'] = this.current.toJson();
    }
    if (this.old != null) {
      data['old'] = this.old.toJson();
    }
    return data;
  }
}
