import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutbar/i3/models/events/barconfig_update_event.dart';
import 'package:flutbar/i3/models/events/binding_event.dart';
import 'package:flutbar/i3/models/events/mode_event.dart';
import 'package:flutbar/i3/models/events/output_event.dart';
import 'package:flutbar/i3/models/events/shutdown_event.dart';
import 'package:flutbar/i3/models/events/tick_event.dart';
import 'package:flutbar/i3/models/events/window_event.dart';
import 'package:flutbar/i3/models/events/worspace_event.dart';
import 'package:flutbar/i3/utils/parser.dart';
import 'package:flutbar/i3/utils/constants.dart';

class EventsConnection {
  String path = Platform.environment['I3SOCK'];
  Socket connection;
  Future<bool> connected;

  final _workspcaceController = StreamController<WorspaceEvent>();
  Stream<WorspaceEvent> get workspcaceEvents =>
      _workspcaceController.stream.asBroadcastStream();

  final _barconfigUpdateController = StreamController<BarConfigEvent>();
  Stream<BarConfigEvent> get barconfigUpdateEvents =>
      _barconfigUpdateController.stream.asBroadcastStream();

  final _bindingController = StreamController<BindingEvent>();
  Stream<BindingEvent> get bindingEvents =>
      _bindingController.stream.asBroadcastStream();

  final _outputController = StreamController<OutputEvent>();
  Stream<OutputEvent> get outputEvents =>
      _outputController.stream.asBroadcastStream();

  final _modeController = StreamController<ModeEvent>();
  Stream<ModeEvent> get modeEvents =>
      _modeController.stream.asBroadcastStream();

  final _shutdownController = StreamController<ShutdownEvent>();
  Stream<ShutdownEvent> get shutdownEvents =>
      _shutdownController.stream.asBroadcastStream();

  final _tickController = StreamController<TickEvent>();
  Stream<TickEvent> get tickEvents =>
      _tickController.stream.asBroadcastStream();

  final _windowController = StreamController<WindowEvent>();
  Stream<WindowEvent> get windowEvents =>
      _windowController.stream.asBroadcastStream();

  EventsConnection() {
    connected = _init();
  }

  Future<bool> _init() {
    final host = InternetAddress(this.path, type: InternetAddressType.unix);
    Future<bool> connection = Socket.connect(host, 0).then((value) {
      if (value == null) {
        return false;
      }
      print("Connected Events");
      this.connection = value;
      this.connection.listen((event) {
        _eventMessage(parse(event));
      });

      return true;
    }).catchError((e) {
      print("Unable to connect: $e");
      return false;
    });

    return connection;
  }

  void _eventMessage(ParseResult result) {
    if (result == null && result.type != null) {
      print('no result or no type');
      return;
    }
    switch (result.type) {
      case EventsTypes.WORKSPACE:
        _workspcaceController.sink
            .add(WorspaceEvent.fromJson(jsonDecode(result.response)));
        break;
      case EventsTypes.BARCONFIG_UPDATE:
        _barconfigUpdateController.sink
            .add(BarConfigEvent.fromJson(jsonDecode(result.response)));
        break;
      case EventsTypes.BINDING:
        _bindingController.sink
            .add(BindingEvent.fromJson(jsonDecode(result.response)));
        break;
      case EventsTypes.MODE:
        _modeController.sink
            .add(ModeEvent.fromJson(jsonDecode(result.response)));
        break;
      case EventsTypes.OUTPUT:
        _outputController.sink
            .add(OutputEvent.fromJson(jsonDecode(result.response)));
        break;
      case EventsTypes.SHUTDOWN:
        _shutdownController.sink
            .add(ShutdownEvent.fromJson(jsonDecode(result.response)));
        break;
      case EventsTypes.TICK:
        _tickController.sink
            .add(TickEvent.fromJson(jsonDecode(result.response)));
        break;
      case EventsTypes.WINDOW:
        _windowController.sink
            .add(WindowEvent.fromJson(jsonDecode(result.response)));
        break;
      default:
        print('Unhandled Event $result.type');
    }
  }

  void subscribe(List<int> channels) async {
    await connected;
    this.connection.write(format(CommandTypes.SUBSCRIBE,
        payload: jsonEncode(channels.map((e) => EventCommandNames[e]))));
  }

  destroy() {
    _workspcaceController.close();
    _barconfigUpdateController.close();
    _bindingController.close();
    _outputController.close();
    _modeController.close();
    _shutdownController.close();
    _tickController.close();
    _windowController.close();
  }
}
