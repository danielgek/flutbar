import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import './models/workspace.dart';

const constants = {
  'MAGIC_STRING': "i3-ipc",
  'TYPES': {
    'COMMAND': 0,
    'GET_WORKSPACES': 1,
    'SUBSCRIBE': 2,
    'GET_OUTPUTS': 3,
    'GET_TREE': 4,
    'GET_MARKS': 5,
    'GET_BAR_CONFIG': 6
  },
  'EVENTS': {'WORKSPACE': 0, 'OUTPUT': 1},
} as Map<dynamic, dynamic>;

packInt(int size, int type) {
  var result = '';
  result += String.fromCharCode(size & 0xFF);
  result += String.fromCharCode(size >> 8 & 0xFF);
  result += String.fromCharCode(size >> 16 & 0xFF);
  result += String.fromCharCode(size >> 24 & 0xFF);
  result += String.fromCharCode(type & 0xFF);
  result += String.fromCharCode(type >> 8 & 0xFF);
  result += String.fromCharCode(type >> 16 & 0xFF);
  result += String.fromCharCode(type >> 24 & 0xFF);

  return result;
}

unpackInt(String str) {
  var b1 = str.codeUnitAt(0) & 0xFF;
  var b2 = str.codeUnitAt(1) & 0xFF;
  var b3 = str.codeUnitAt(2) & 0xFF;
  var b4 = str.codeUnitAt(3) & 0xFF;

  return (((((b4 << 8) + b3) << 8) + b2) << 8) + b1;
}

format(int type, {String payload = ''}) {
  var size = payload.length;
  var msg = constants['MAGIC_STRING'];
  msg += packInt(size, type);
  msg += payload;
  print(msg);
  return msg;
}

parse(Uint8List data) {
  String content = String.fromCharCodes(data);
  if (content.substring(0, constants['MAGIC_STRING'].length).toString() !=
      constants['MAGIC_STRING']) {
    return {'error': 'wrong magic code'};
  }

  var size = unpackInt(content
      .substring(constants['MAGIC_STRING'].length,
          constants['MAGIC_STRING'].length + 4)
      .toString());
  var type = unpackInt(content
      .substring(constants['MAGIC_STRING'].length + 4,
          constants['MAGIC_STRING'].length + 8)
      .toString());
  String response =
      content.substring(constants['MAGIC_STRING'].length + 8, data.length);

  bool event = false;
  /**
   * got an event? high bit is set!
   * the implemantation of unpackInt
   * seems a little bit wrong;
   * should return 1 here, right?
   **/
  if ((type >> 31) == -1) {
    event = true;
    type = type & 0x7f;
  }

  return {"event": event, "size": size, "type": type, "response": response};
}

class I3Connection {
  String path = Platform.environment['I3SOCK'];
  Socket connection;
  Future inited;

  List<WorkSpace> workspaces;
  I3Connection() {
    inited = init();
  }

  Future<Socket> init() async {
    final host = InternetAddress(this.path, type: InternetAddressType.unix);
    Future<Socket> connection = Socket.connect(host, 0).then((value) {
      print("connected");
      this.connection = value;

      // this.connection.listen((event) {
      //   parse(event);
      // });
      return value;
    }).catchError((e) {
      print("Unable to connect: $e");
      exit(1);
    });

    return connection;
  }

  Future<List<WorkSpace>> getWorkspaces() async {
    await inited;
    print('inited');
    print(inited);
    final completer = Completer<List<WorkSpace>>();
    final sub = this.connection.listen((event) {
      var parsed = parse(event);
      var type = parsed['type'];
      var response = parsed['response'];
      if (type == constants['TYPES']['GET_WORKSPACES']) {
        print(WorkSpace.fromJsonString(response));
        completer.complete(WorkSpace.fromJsonString(response));
      }
    });
    this.connection.write(format(constants['TYPES']['GET_WORKSPACES']));

    //completer.future.whenComplete(() => sub.cancel());
    return completer.future;
  }

  goToWorkspace(int index) {
    this.connection.write(format(constants['TYPES']['COMMAND'],
        payload: 'workspace number ${index}'));
  }

  customWrite(String str) {
    this.connection.write(str);
  }
}
