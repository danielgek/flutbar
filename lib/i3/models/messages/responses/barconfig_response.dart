import 'dart:convert';

import 'package:flutbar/i3/models/common/colors.dart';
import 'package:flutbar/i3/models/common/gaps.dart';

class BarConfigResponse {
  String id;
  String mode;
  String position;
  String statusCommand;
  String font;
  Gaps? gaps;
  int barHeight;
  int statusPadding;
  int statusEdgePadding;
  bool workspaceButtons;
  int workspaceMinWidth;
  bool bindingModeIndicator;
  bool verbose;
  bool pangoMarkup;
  Colors? colors;

  BarConfigResponse(
      {required this.id,
      required this.mode,
      required this.position,
      required this.statusCommand,
      required this.font,
      required this.gaps,
      required this.barHeight,
      required this.statusPadding,
      required this.statusEdgePadding,
      required this.workspaceButtons,
      required this.workspaceMinWidth,
      required this.bindingModeIndicator,
      required this.verbose,
      required this.pangoMarkup,
      required this.colors});

  BarConfigResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        mode = json['mode'] as String,
        position = json['position'] as String,
        statusCommand = json['status_command'] as String,
        font = json['font'] as String,
        gaps = json['gaps'] != null ? new Gaps.fromJson(json['gaps']) : null,
        barHeight = json['bar_height'] as int,
        statusPadding = json['status_padding'] as int,
        statusEdgePadding = json['status_edge_padding'] as int,
        workspaceButtons = json['workspace_buttons'] as bool,
        workspaceMinWidth = json['workspace_min_width'] as int,
        bindingModeIndicator = json['binding_mode_indicator'] as bool,
        verbose = json['verbose'] as bool,
        pangoMarkup = json['pango_markup'] as bool,
        colors =
            json['colors'] != null ? new Colors.fromJson(json['colors']) : null;

  factory BarConfigResponse.fromJsonString(String json) {
    return BarConfigResponse.fromJson(jsonDecode(json));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mode'] = this.mode;
    data['position'] = this.position;
    data['status_command'] = this.statusCommand;
    data['font'] = this.font;
    if (this.gaps != null) {
      data['gaps'] = this.gaps?.toJson();
    }
    data['bar_height'] = this.barHeight;
    data['status_padding'] = this.statusPadding;
    data['status_edge_padding'] = this.statusEdgePadding;
    data['workspace_buttons'] = this.workspaceButtons;
    data['workspace_min_width'] = this.workspaceMinWidth;
    data['binding_mode_indicator'] = this.bindingModeIndicator;
    data['verbose'] = this.verbose;
    data['pango_markup'] = this.pangoMarkup;
    if (this.colors != null) {
      data['colors'] = this.colors?.toJson();
    }
    return data;
  }
}
