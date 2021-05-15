import 'dart:convert';

import 'package:flutbar/i3/models/common/rect.dart';

class BarsConfigResponse {
  List<String> bars;

  BarsConfigResponse(this.bars);

  static BarsConfigResponse fromJsonString(String json) {
    var tagObjsJson = jsonDecode('{ "list":' + json + '}')['list'] as List;
    return BarsConfigResponse(
        tagObjsJson.map((tagJson) => tagJson.toString()).toList());
  }

  @override
  String toString() {
    return '{ bars: ${this.bars} }';
  }
}
