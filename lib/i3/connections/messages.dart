import 'dart:async';
import 'dart:io';

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

class MessagesConnection {
  Socket connection;

  final _messageController = StreamController<ParseResult>.broadcast();
  Stream<ParseResult> get messageEvents => _messageController.stream;
  MessagesConnection({required this.connection}) {
    print("Connected MessagesConnection");
    this.connection.listen((events) {
      parse(events).forEach((event) {
        this._messageController.sink.add(event);
      });
    });
  }
  static Future<MessagesConnection> getInstance() async {
    final host = InternetAddress(Platform.environment['I3SOCK'] as String,
        type: InternetAddressType.unix);
    return MessagesConnection(connection: await Socket.connect(host, 0));
  }

  Future<List<WorkSpace>> get workspaces {
    this.connection.write(format(CommandTypes.GET_WORKSPACES));

    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_WORKSPACES)
        .map((event) => parseResultByType<Workspaces>(event))
        .first;
  }

  Future<List<CommandResponse>> runCommands(List<String> commands) {
    this
        .connection
        .write(format(CommandTypes.RUN_COMMAND, payload: commands.join(';')));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.RUN_COMMAND)
        .map((event) => parseResultByType<List<CommandResponse>>(event))
        .first;
  }

  Future<BarsConfigResponse> get barConfigIds {
    this.connection.write(format(CommandTypes.GET_BAR_CONFIG));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_BAR_CONFIG)
        .map((event) => parseResultByType<BarsConfigResponse>(event))
        .first;
  }

  Future<BarConfigResponse> getBarConfigById(String id) {
    this.connection.write(format(CommandTypes.GET_BAR_CONFIG, payload: id));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_BAR_CONFIG)
        .map((event) => parseResultByType<BarConfigResponse>(event))
        .first;
  }

  Future<BindingModesResponse> get bindingModes {
    this.connection.write(format(CommandTypes.GET_BINDING_MODES));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_BINDING_MODES)
        .map((event) => parseResultByType<BindingModesResponse>(event))
        .first;
  }

  Future<BindingStateResponse> get bindingModeState {
    this.connection.write(format(CommandTypes.GET_BINDING_STATE));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_BINDING_STATE)
        .map((event) => parseResultByType<BindingStateResponse>(event))
        .first;
  }

  Future<ConfigResponse> get config {
    this.connection.write(format(CommandTypes.GET_CONFIG));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_CONFIG)
        .map((event) => parseResultByType<ConfigResponse>(event))
        .first;
  }

  Future<MarkResponse> get marks {
    this.connection.write(format(CommandTypes.GET_MARKS));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_MARKS)
        .map((event) => parseResultByType<MarkResponse>(event))
        .first;
  }

  Future<List<OutputResponse>> get outputs {
    this.connection.write(format(CommandTypes.GET_OUTPUTS));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_OUTPUTS)
        .map((event) => parseResultByType<List<OutputResponse>>(event))
        .first;
  }

  Future<TreeResponse> get tree {
    this.connection.write(format(CommandTypes.GET_TREE));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_TREE)
        .map((event) => parseResultByType<TreeResponse>(event))
        .first;
  }

  Future<VersionResponse> get version {
    this.connection.write(format(CommandTypes.GET_VERSION));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_VERSION)
        .map((event) => parseResultByType<VersionResponse>(event))
        .first;
  }

  T parseResultByType<T>(ParseResult result) {
    switch (result.type) {
      case CommandTypes.GET_WORKSPACES:
        return WorkSpace.fromJsonString(result.response) as T;
      case CommandTypes.RUN_COMMAND:
        return CommandResponse.fromJsonString(result.response) as T;
      case CommandTypes.GET_BAR_CONFIG:
        // TODO: this command works for two things depending on the payload when the command is sent
        // return BarConfigResponse.fromJsonString(result.response) as T;
        return BarsConfigResponse.fromJsonString(result.response) as T;
      case CommandTypes.GET_BINDING_MODES:
        return BindingModesResponse.fromJsonString(result.response) as T;
      case CommandTypes.GET_BINDING_STATE:
        return BindingStateResponse.fromJsonString(result.response) as T;
      case CommandTypes.GET_CONFIG:
        return ConfigResponse.fromJsonString(result.response) as T;
      case CommandTypes.GET_MARKS:
        return MarkResponse.fromJsonString(result.response) as T;
      case CommandTypes.GET_OUTPUTS:
        return OutputResponse.fromJsonString(result.response) as T;
      case CommandTypes.GET_TREE:
        return TreeResponse.fromJsonString(result.response) as T;
      case CommandTypes.GET_VERSION:
        return VersionResponse.fromJsonString(result.response) as T;
      default:
        throw 'Type not supported: ' + result.type.toString();
    }
  }

  Stream<T> messages<T>() {
    return _messageController.stream
        .where((event) => ResponseTypes.isOfType<T>(event.type))
        .map((event) => parseResultByType<T>(event));
  }

  destroy() {
    _messageController.close();
  }
}
