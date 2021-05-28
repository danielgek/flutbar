import 'dart:convert';

import 'package:flutbar/i3/models/common/rect.dart';

class WorkSpace {
  String name;
  int id;
  int index;
  bool visible;
  bool focused;
  Rect rect;

  WorkSpace(
      {required this.name,
      required this.id,
      required this.index,
      required this.visible,
      required this.focused,
      required this.rect});

  factory WorkSpace.fromJson(dynamic json) {
    return WorkSpace(
        name: json['name'] as String,
        id: json['id'] as int,
        index: json['num'] as int,
        visible: json['visible'] as bool,
        focused: json['focused'] as bool,
        rect: Rect.fromJson(json['rect']));
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

typedef Workspaces = List<WorkSpace>;
