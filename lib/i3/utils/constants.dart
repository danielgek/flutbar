import 'package:flutbar/i3/models/messages/responses/barconfig_response.dart';
import 'package:flutbar/i3/models/messages/responses/barsconfig_response.dart';
import 'package:flutbar/i3/models/messages/responses/bindingmodes_response.dart';
import 'package:flutbar/i3/models/messages/responses/bindingstate_response.dart';
import 'package:flutbar/i3/models/messages/responses/config_response.dart';
import 'package:flutbar/i3/models/messages/responses/mark_response.dart';
import 'package:flutbar/i3/models/messages/responses/output_response.dart';
import 'package:flutbar/i3/models/messages/responses/run_commands_response.dart';
import 'package:flutbar/i3/models/messages/responses/tree_response.dart';
import 'package:flutbar/i3/models/messages/responses/version_response.dart';
import 'package:flutbar/i3/models/messages/responses/workspaces_respose.dart';

const MAGIC_STRING = "i3-ipc";

class CommandTypes {
  static const int RUN_COMMAND = 0;
  static const int GET_WORKSPACES = 1;
  static const int SUBSCRIBE = 2;
  static const int GET_OUTPUTS = 3;
  static const int GET_TREE = 4;
  static const int GET_MARKS = 5;
  static const int GET_BAR_CONFIG = 6;
  static const int GET_VERSION = 7;
  static const int GET_BINDING_MODES = 8;
  static const int GET_CONFIG = 9;
  static const int SEND_TICK = 10;
  static const int SYNC = 11;
  static const int GET_BINDING_STATE = 12;
}

class ResponseTypes {
  static const int RUN_COMMAND = 0;
  static const int GET_WORKSPACES = 1;
  static const int SUBSCRIBE = 2;
  static const int GET_OUTPUTS = 3;
  static const int GET_TREE = 4;
  static const int GET_MARKS = 5;
  static const int GET_BAR_CONFIG = 6;
  static const int GET_VERSION = 7;
  static const int GET_BINDING_MODES = 8;
  static const int GET_CONFIG = 9;
  static const int SEND_TICK = 10;
  static const int SYNC = 11;
  static const int GET_BINDING_STATE = 12;
  static bool isOfType<T>(int type) {
    if (T is Workspaces) {
      return type == ResponseTypes.GET_WORKSPACES;
    } else if (T is List<CommandResponse>) {
      return type == ResponseTypes.RUN_COMMAND;
    } else if (T is BarsConfigResponse || T is BarConfigResponse) {
      return type == ResponseTypes.GET_BAR_CONFIG;
    } else if (T is BindingModesResponse) {
      return type == ResponseTypes.GET_BINDING_MODES;
    } else if (T is BindingStateResponse) {
      return type == ResponseTypes.GET_BINDING_STATE;
    } else if (T is ConfigResponse) {
      return type == ResponseTypes.GET_CONFIG;
    } else if (T is MarkResponse) {
      return type == ResponseTypes.GET_MARKS;
    } else if (T is OutputResponse) {
      return type == ResponseTypes.GET_OUTPUTS;
    } else if (T is TreeResponse) {
      return type == ResponseTypes.GET_TREE;
    } else if (T is VersionResponse) {
      return type == ResponseTypes.GET_VERSION;
    } else {
      throw 'Type not supported';
    }
  }
}

class EventsTypes {
  static const int WORKSPACE = 0;
  static const int OUTPUT = 1;
  static const int MODE = 2;
  static const int WINDOW = 3;
  static const int BARCONFIG_UPDATE = 4;
  static const int BINDING = 5;
  static const int SHUTDOWN = 6;
  static const int TICK = 7;
}

final List<String> EventCommandNames =
    "workspace output mode window barconfig_update binding shutdown tick"
        .split(' ');
