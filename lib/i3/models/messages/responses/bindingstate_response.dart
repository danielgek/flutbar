import 'dart:convert';

class BindingStateResponse {
  String name;

  BindingStateResponse({required this.name});

  BindingStateResponse.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String;

  factory BindingStateResponse.fromJsonString(String json) {
    return BindingStateResponse.fromJson(jsonDecode(json));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
