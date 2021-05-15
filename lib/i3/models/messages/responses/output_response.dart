import 'dart:convert';

class OutputResponse {
  String name;
  String make;
  String model;
  String serial;
  bool active;
  bool primary;
  int scale;
  String subpixelHinting;
  String transform;
  String currentWorkspace;
  List<Modes> modes;
  Modes currentMode;

  OutputResponse(
      {this.name,
      this.make,
      this.model,
      this.serial,
      this.active,
      this.primary,
      this.scale,
      this.subpixelHinting,
      this.transform,
      this.currentWorkspace,
      this.modes,
      this.currentMode});

  OutputResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    make = json['make'];
    model = json['model'];
    serial = json['serial'];
    active = json['active'];
    primary = json['primary'];
    scale = json['scale'];
    subpixelHinting = json['subpixel_hinting'];
    transform = json['transform'];
    currentWorkspace = json['current_workspace'];
    if (json['modes'] != null) {
      modes = new List<Modes>();
      json['modes'].forEach((v) {
        modes.add(new Modes.fromJson(v));
      });
    }
    currentMode = json['current_mode'] != null
        ? new Modes.fromJson(json['current_mode'])
        : null;
  }

  static List<OutputResponse> fromJsonString(String json) {
    var tagObjsJson = jsonDecode('{ "list":' + json + '}')['list'] as List;
    return tagObjsJson
        .map((tagJson) => OutputResponse.fromJson(tagJson))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['make'] = this.make;
    data['model'] = this.model;
    data['serial'] = this.serial;
    data['active'] = this.active;
    data['primary'] = this.primary;
    data['scale'] = this.scale;
    data['subpixel_hinting'] = this.subpixelHinting;
    data['transform'] = this.transform;
    data['current_workspace'] = this.currentWorkspace;
    if (this.modes != null) {
      data['modes'] = this.modes.map((v) => v.toJson()).toList();
    }
    if (this.currentMode != null) {
      data['current_mode'] = this.currentMode.toJson();
    }
    return data;
  }
}

class Modes {
  int width;
  int height;
  int refresh;

  Modes({this.width, this.height, this.refresh});

  Modes.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['refresh'] = this.refresh;
    return data;
  }
}
