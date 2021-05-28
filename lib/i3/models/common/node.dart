import 'dart:convert';

import 'package:flutbar/i3/models/common/gaps.dart';
import 'package:flutbar/i3/models/common/rect.dart';

// TODO: i think theres a missin parenrt Node on this class, not sure yet
class Node {
  int id;
  String type;
  String orientation;
  String scratchpadState;
  double percent;
  bool urgent;
  bool focused;
  String output;
  String layout;
  String workspaceLayout;
  String lastSplitLayout;
  String border;
  int currentBorderWidth;
  Rect rect;
  Rect decoRect;
  Rect windowRect;
  Rect geometry;
  String name;
  int? num;
  Gaps? gaps;
  int? window;
  String? windowType;
  List<Node> nodes;
  List<Node> floatingNodes;
  List<int> focus;
  int fullscreenMode;
  bool sticky;
  String floating;
  List<Null>? swallows;

  Node(
      {required this.id,
      required this.type,
      required this.orientation,
      required this.scratchpadState,
      required this.percent,
      required this.urgent,
      required this.focused,
      required this.output,
      required this.layout,
      required this.workspaceLayout,
      required this.lastSplitLayout,
      required this.border,
      required this.currentBorderWidth,
      required this.rect,
      required this.decoRect,
      required this.windowRect,
      required this.geometry,
      required this.name,
      required this.num,
      required this.gaps,
      required this.window,
      required this.windowType,
      required this.nodes,
      required this.floatingNodes,
      required this.focus,
      required this.fullscreenMode,
      required this.sticky,
      required this.floating});

  Node.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        orientation = json['orientation'],
        scratchpadState = json['scratchpad_state'],
        percent = json['percent'],
        urgent = json['urgent'],
        focused = json['focused'],
        output = json['output'],
        layout = json['layout'],
        workspaceLayout = json['workspace_layout'],
        lastSplitLayout = json['last_split_layout'],
        border = json['border'],
        currentBorderWidth = json['current_border_width'],
        rect = Rect.fromJson(json['rect']),
        decoRect = Rect.fromJson(json['deco_rect']),
        windowRect = Rect.fromJson(json['window_rect']),
        geometry = Rect.fromJson(json['geometry']),
        name = json['name'],
        num = json['num'],
        gaps = json['gaps'] != null ? new Gaps.fromJson(json['gaps']) : null,
        window = json['window'],
        windowType = json['window_type'],
        nodes = json['nodes'] != null
            ? List<Node>.from(json['nodes'].map((v) => new Node.fromJson(v)))
            : [],
        floatingNodes = json['floating_nodes'] != null
            ? List<Node>.from(
                json['floating_nodes'].map((v) => new Node.fromJson(v)))
            : [],
        focus = json['focus'].cast<int>(),
        fullscreenMode = json['fullscreen_mode'],
        sticky = json['sticky'],
        floating = json['floating'];
  // if (json['swallows'] != null && json['swallows']) {
  //   // swallows = new List<Null>();
  //   // json['swallows'].forEach((v) { swallows.add(new Null.fromJson(v)); });
  //   print('WOW found a swallows');
  //   print(json['swallows']);
  // }

  static List<Node> fromJsonString(String json) {
    var tagObjsJson = jsonDecode('{ "list":' + json + '}')['list'] as List;
    return tagObjsJson.map((tagJson) => new Node.fromJson(tagJson)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['orientation'] = this.orientation;
    data['scratchpad_state'] = this.scratchpadState;
    data['percent'] = this.percent;
    data['urgent'] = this.urgent;
    data['focused'] = this.focused;
    data['output'] = this.output;
    data['layout'] = this.layout;
    data['workspace_layout'] = this.workspaceLayout;
    data['last_split_layout'] = this.lastSplitLayout;
    data['border'] = this.border;
    data['current_border_width'] = this.currentBorderWidth;
    if (this.rect != null) {
      data['rect'] = this.rect.toJson();
    }
    if (this.decoRect != null) {
      data['deco_rect'] = this.decoRect.toJson();
    }
    if (this.windowRect != null) {
      data['window_rect'] = this.windowRect.toJson();
    }
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    data['name'] = this.name;
    data['num'] = this.num;
    if (this.gaps != null) {
      data['gaps'] = this.gaps?.toJson();
    }
    data['window'] = this.window;
    data['window_type'] = this.windowType;
    if (this.nodes != null) {
      data['nodes'] = this.nodes.map((v) => v.toJson()).toList();
    }
    if (this.floatingNodes != null) {
      data['floating_nodes'] =
          this.floatingNodes.map((v) => v.toJson()).toList();
    }
    data['focus'] = this.focus;
    data['fullscreen_mode'] = this.fullscreenMode;
    data['sticky'] = this.sticky;
    data['floating'] = this.floating;
    // if (this.swallows != null) {
    //   data['swallows'] = this.swallows.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
