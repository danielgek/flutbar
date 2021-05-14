import 'dart:convert';

class Rect {
  int x;
  int y;
  int width;
  int height;

  Rect(this.x, this.y, this.width, this.height);

  factory Rect.fromJson(dynamic json) {
    return Rect(json['x'] as int, json['y'] as int, json['width'] as int,
        json['height'] as int);
  }

  @override
  String toString() {
    return '{ ${this.x}, ${this.y},${this.width}, ${this.height} }';
  }
}

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
