import 'dart:convert';

class CommandResponse {
  bool success;
  bool parseError;
  String error;

  CommandResponse(
      {required this.success, required this.parseError, required this.error});

  CommandResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool,
        parseError = json['parse_error'] as bool,
        error = json['error'] as String;

  static List<CommandResponse> fromJsonString(String json) {
    var tagObjsJson = jsonDecode('{ "list":' + json + '}')['list'] as List;
    return tagObjsJson
        .map((tagJson) => CommandResponse.fromJson(tagJson))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['parse_error'] = this.parseError;
    data['error'] = this.error;
    return data;
  }
}
