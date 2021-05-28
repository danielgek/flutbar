import 'dart:convert';

class ConfigResponse {
  String config;

  ConfigResponse({required this.config});

  ConfigResponse.fromJson(Map<String, dynamic> json)
      : config = json['config'] as String;

  factory ConfigResponse.fromJsonString(String json) {
    return ConfigResponse.fromJson(jsonDecode(json));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['config'] = this.config;
    return data;
  }
}
