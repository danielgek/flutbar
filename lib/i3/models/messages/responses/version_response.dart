import 'dart:convert';

class VersionResponse {
  String humanReadable;
  int major;
  int minor;
  int patch;
  String loadedConfigFileName;

  VersionResponse(
      {this.humanReadable,
      this.major,
      this.minor,
      this.patch,
      this.loadedConfigFileName});

  VersionResponse.fromJson(Map<String, dynamic> json) {
    humanReadable = json['human_readable'];
    major = json['major'];
    minor = json['minor'];
    patch = json['patch'];
    loadedConfigFileName = json['loaded_config_file_name'];
  }

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
