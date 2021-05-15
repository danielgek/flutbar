import 'dart:convert';

class ConfigResponse {
  String config;

  ConfigResponse(this.config);

  ConfigResponse.fromJson(Map<String, dynamic> json) {
    ConfigResponse(config = json['config']);
  }

  factory ConfigResponse.fromJsonString(String json) {
    var tagObjsJson = jsonDecode(json);
    return ConfigResponse(
        tagObjsJson.map((tagJson) => tagJson.toString()).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['config'] = this.config;
    return data;
  }
}
