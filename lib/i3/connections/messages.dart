import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutbar/i3/models/common/binding.dart';
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
import 'package:flutbar/i3/utils/parser.dart';
import 'package:flutbar/i3/utils/constants.dart';

class MassagesConnection {
  String path = Platform.environment['I3SOCK'];
  Socket connection;
  Future<bool> connected;

  final _messageController = StreamController<ParseResult>.broadcast();
  Stream<ParseResult> get messageEvents =>
      _messageController.stream.where((event) => event.type != null);

  MassagesConnection() {
    connected = _init();
  }

  Future<bool> _init() {
    final host = InternetAddress(this.path, type: InternetAddressType.unix);
    Future<bool> connection = Socket.connect(host, 0).then((value) {
      if (value == null) {
        return false;
      }
      print("Connected Messages");
      this.connection = value;
      this.connection.listen((event) {
        this._messageController.sink.add(parse(event));
      });

      return true;
    }).catchError((e) {
      print("Unable to connect: $e");
      return false;
    });

    return connection;
  }

  Stream<List<WorkSpace>> get workspaces {
    this.connected.then(
        (value) => this.connection.write(format(CommandTypes.GET_WORKSPACES)));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_WORKSPACES)
        .map((event) => WorkSpace.fromJsonString(event.response));
  }

  Stream<List<CommandResponse>> runCommands(List<String> commands) {
    this.connected.then((value) => this
        .connection
        .write(format(CommandTypes.RUN_COMMAND, payload: commands.join(';'))));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.RUN_COMMAND)
        .map((event) => CommandResponse.fromJsonString(event.response));
  }

  Stream<BarsConfigResponse> get barConfigIds {
    this.connected.then(
        (value) => this.connection.write(format(CommandTypes.GET_BAR_CONFIG)));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_BAR_CONFIG)
        .map((event) => BarsConfigResponse.fromJsonString(event.response));
  }

  Stream<BarConfigResponse> getBarConfigById(String id) {
    this.connected.then((value) => this
        .connection
        .write(format(CommandTypes.GET_BAR_CONFIG, payload: id)));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_BAR_CONFIG)
        .map((event) => BarConfigResponse.fromJsonString(event.response));
  }

  Stream<BindingModesResponse> get bindingModes {
    this.connected.then((value) =>
        this.connection.write(format(CommandTypes.GET_BINDING_MODES)));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_BINDING_MODES)
        .map((event) => BindingModesResponse.fromJsonString(event.response));
  }

  Stream<BindingStateResponse> get bindingModeState {
    this.connected.then((value) =>
        this.connection.write(format(CommandTypes.GET_BINDING_STATE)));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_BINDING_STATE)
        .map((event) => BindingStateResponse.fromJsonString(event.response));
  }

  Stream<ConfigResponse> get config {
    this.connected.then(
        (value) => this.connection.write(format(CommandTypes.GET_CONFIG)));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_CONFIG)
        .map((event) => ConfigResponse.fromJsonString(event.response));
  }

  Stream<MarkResponse> get marks {
    this
        .connected
        .then((value) => this.connection.write(format(CommandTypes.GET_MARKS)));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_MARKS)
        .map((event) => MarkResponse.fromJsonString(event.response));
  }

  Stream<List<OutputResponse>> get outputs {
    this.connected.then(
        (value) => this.connection.write(format(CommandTypes.GET_OUTPUTS)));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_OUTPUTS)
        .map((event) => OutputResponse.fromJsonString(event.response));
  }

  Stream<TreeResponse> get tree {
    this
        .connected
        .then((value) => this.connection.write(format(CommandTypes.GET_TREE)));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_TREE)
        .map((event) => TreeResponse.fromJsonString(event.response));
  }

  Stream<VersionResponse> get version {
    this.connected.then(
        (value) => this.connection.write(format(CommandTypes.GET_VERSION)));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_VERSION)
        .map((event) => VersionResponse.fromJsonString(event.response));
  }

  destroy() {
    _messageController.close();
  }
}
