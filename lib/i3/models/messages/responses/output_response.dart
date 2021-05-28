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
  List<Mode> modes;
  Mode currentMode;

  OutputResponse(
      {required this.name,
      required this.make,
      required this.model,
      required this.serial,
      required this.active,
      required this.primary,
      required this.scale,
      required this.subpixelHinting,
      required this.transform,
      required this.currentWorkspace,
      required this.modes,
      required this.currentMode});

  OutputResponse.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        make = json['make'] as String,
        model = json['model'] as String,
        serial = json['serial'] as String,
        active = json['active'],
        primary = json['primary'],
        scale = json['scale'],
        subpixelHinting = json['subpixel_hinting'] as String,
        transform = json['transform'] as String,
        currentWorkspace = json['current_workspace'] as String,
        modes = json['modes'] != null
            ? json['modes'].map((v) => new Mode.fromJson(v))
            : [],
        currentMode = Mode.fromJson(json['current_mode']);

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

class Mode {
  int width;
  int height;
  int refresh;

  Mode({required this.width, required this.height, required this.refresh});

  Mode.fromJson(Map<String, dynamic> json)
      : width = json['width'],
        height = json['height'],
        refresh = json['refresh'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['refresh'] = this.refresh;
    return data;
  }
}
