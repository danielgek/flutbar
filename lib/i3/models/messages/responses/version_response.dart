import 'dart:convert';

class VersionResponse {
  String humanReadable;
  int major;
  int minor;
  int patch;
  String loadedConfigFileName;

  VersionResponse(
      {required this.humanReadable,
      required this.major,
      required this.minor,
      required this.patch,
      required this.loadedConfigFileName});

  VersionResponse.fromJson(Map<String, dynamic> json)
      : humanReadable = json['human_readable'] as String,
        major = json['major'] as int,
        minor = json['minor'] as int,
        patch = json['patch'] as int,
        loadedConfigFileName = json['loaded_config_file_name'];

  factory VersionResponse.fromJsonString(String json) {
    return VersionResponse.fromJson(jsonDecode(json));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['human_readable'] = this.humanReadable;
    data['major'] = this.major;
    data['minor'] = this.minor;
    data['patch'] = this.patch;
    data['loaded_config_file_name'] = this.loadedConfigFileName;
    return data;
  }
}
