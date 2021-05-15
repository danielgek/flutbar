import 'dart:convert';

import 'package:flutbar/i3/models/common/gaps.dart';
import 'package:flutbar/i3/models/common/node.dart';
import 'package:flutbar/i3/models/common/rect.dart';

class TreeResponse extends Node {
  static TreeResponse fromJsonString(String json) {
    return Node.fromJson(jsonDecode(json)) as TreeResponse;
  }
}
