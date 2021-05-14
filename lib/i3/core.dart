import 'dart:async';
import 'dart:io';

import 'package:flutbar/i3/parser.dart';
import 'package:flutbar/i3/utils/constants.dart';
import 'package:flutbar/i3/models/workspace.dart';

class I3Connection {
  String path = Platform.environment['I3SOCK'];
  Socket connection;
  Future<bool> connected;

  I3Connection() {
    connected = _init();
  }

  final _messageController = StreamController<ParseResult>.broadcast();
  Stream<ParseResult> get messageEvents =>
      _messageController.stream.where((event) => event.type != null);

  final _eventsController = StreamController<List<WorkSpace>>();
  Stream<List<WorkSpace>> get generalEvents =>
      _eventsController.stream.asBroadcastStream();

  Future<bool> _init() {
    final host = InternetAddress(this.path, type: InternetAddressType.unix);
    Future<bool> connection = Socket.connect(host, 0).then((value) {
      if (value == null) {
        return false;
      }
      print("connected");
      this.connection = value;
      this.connection.listen((event) {
        _onMessage(parse(event));
      });
      // this.connection.write(
      //     format(CommandTypes.SUBSCRIBE, payload: '[ "workspace", "output" ]'));

      return true;
    }).catchError((e) {
      print("Unable to connect: $e");
      return false;
    });

    return connection;
  }

  void _onMessage(ParseResult result) {
    if (result == null && result.type != null) {
      print('no result');
      return;
    }
    if (result.event == true) {
      _onGeneralEvent(result);
    } else {
      print(result);
      this._messageController.sink.add(result);
      // _onMessageResponse(result);
    }
  }

  // void _onMessageResponse(ParseResult result) {

  //   switch (result.type) {
  //     case CommandTypes.GET_WORKSPACES:
  //       this._messageController.sink.add(WorkSpace.fromJsonString(result.response));
  //       break;
  //     default:
  //   }
  // }

  void _onGeneralEvent(ParseResult result) {
    print('general event: $result');
  }

  Stream<List<WorkSpace>> getWorkspaces() {
    this.connected.then(
        (value) => this.connection.write(format(CommandTypes.GET_WORKSPACES)));
    return this
        .messageEvents
        .where((event) => event.type == CommandTypes.GET_WORKSPACES)
        .map((event) => WorkSpace.fromJsonString(event.response));
  }

  goToWorkspace(int index) {
    this.connection.write(
        format(CommandTypes.RUN_COMMAND, payload: 'workspace number $index'));
  }

  customWrite(String str) {
    this.connection.write(str);
  }
}
