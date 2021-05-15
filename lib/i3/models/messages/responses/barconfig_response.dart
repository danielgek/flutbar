import 'dart:convert';

import 'package:flutbar/i3/models/common/colors.dart';
import 'package:flutbar/i3/models/common/gaps.dart';

class BarConfigResponse {
  String id;
  String mode;
  String position;
  String statusCommand;
  String font;
  Gaps gaps;
  int barHeight;
  int statusPadding;
  int statusEdgePadding;
  bool workspaceButtons;
  int workspaceMinWidth;
  bool bindingModeIndicator;
  bool verbose;
  bool pangoMarkup;
  Colors colors;

  BarConfigResponse(
      {this.id,
      this.mode,
      this.position,
      this.statusCommand,
      this.font,
      this.gaps,
      this.barHeight,
      this.statusPadding,
      this.statusEdgePadding,
      this.workspaceButtons,
      this.workspaceMinWidth,
      this.bindingModeIndicator,
      this.verbose,
      this.pangoMarkup,
      this.colors});

  BarConfigResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mode = json['mode'];
    position = json['position'];
    statusCommand = json['status_command'];
    font = json['font'];
    gaps = json['gaps'] != null ? new Gaps.fromJson(json['gaps']) : null;
    barHeight = json['bar_height'];
    statusPadding = json['status_padding'];
    statusEdgePadding = json['status_edge_padding'];
    workspaceButtons = json['workspace_buttons'];
    workspaceMinWidth = json['workspace_min_width'];
    bindingModeIndicator = json['binding_mode_indicator'];
    verbose = json['verbose'];
    pangoMarkup = json['pango_markup'];
    colors =
        json['colors'] != null ? new Colors.fromJson(json['colors']) : null;
  }

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
      data['gaps'] = this.gaps.toJson();
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
      data['colors'] = this.colors.toJson();
    }
    return data;
  }
}
