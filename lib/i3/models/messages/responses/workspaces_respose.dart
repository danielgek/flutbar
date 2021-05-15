import 'dart:convert';

import 'package:flutbar/i3/models/common/rect.dart';

class WorkSpace {
  String name;
  int id;
  int index;
  bool visible;
  bool focused;
  Rect rect;

  WorkSpace(this.name, this.id, this.index, this.visible, this.focused);

  factory WorkSpace.fromJson(dynamic json) {
    return WorkSpace(json['name'] as String, json['id'] as int,
        json['num'] as int, json['visible'] as bool, json['focused'] as bool);
  }

  static List<WorkSpace> fromJsonString(String json) {
    var tagObjsJson = jsonDecode('{ "list":' + json + '}')['list'] as List;
    return tagObjsJson.map((tagJson) => WorkSpace.fromJson(tagJson)).toList();
  }

  @override
  String toString() {
    return '{ name: ${this.name}, id: ${this.id}, index: ${this.index}, visible: ${this.visible}, focused: ${this.focused} }';
  }
}
