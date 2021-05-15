import 'dart:convert';

import 'package:flutbar/i3/models/common/rect.dart';

class BindingModesResponse {
  List<String> modes;

  BindingModesResponse(this.modes);

  factory BindingModesResponse.fromJsonString(String json) {
    var tagObjsJson = jsonDecode('{ "list":' + json + '}')['list'] as List;
    return BindingModesResponse(
        tagObjsJson.map((tagJson) => tagJson.toString()).toList());
  }

  @override
  String toString() {
    return '{ modes: ${this.modes} }';
  }
}
