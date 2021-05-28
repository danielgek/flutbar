import 'package:flutbar/i3/models/common/node.dart';

class WorspaceEvent {
  String change;
  Node current;
  Node old;

  WorspaceEvent(
      {required this.change, required this.current, required this.old});

  WorspaceEvent.fromJson(Map<String, dynamic> json)
      : change = json['change'],
        current = Node.fromJson(json['current']),
        old = Node.fromJson(json['old']);

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

  @override
  String toString() => "Workspace Event -> change: $change";
}
