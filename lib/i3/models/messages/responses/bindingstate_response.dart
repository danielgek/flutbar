import 'dart:convert';

class BindingStateResponse {
  String name;

  BindingStateResponse(this.name);

  BindingStateResponse.fromJson(Map<String, dynamic> json) {
    BindingStateResponse(name = json['name']);
  }

  factory BindingStateResponse.fromJsonString(String json) {
    return BindingStateResponse.fromJson(jsonDecode(json));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
