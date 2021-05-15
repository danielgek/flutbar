import 'dart:convert';

import 'package:flutbar/i3/models/common/rect.dart';

class MarkResponse {
  List<String> marks;

  MarkResponse(this.marks);

  static MarkResponse fromJsonString(String json) {
    var tagObjsJson = jsonDecode('{ "list":' + json + '}')['list'] as List;
    return MarkResponse(
        tagObjsJson.map((tagJson) => tagJson.toString()).toList());
  }

  @override
  String toString() {
    return '{ marks: ${this.marks} }';
  }
}
