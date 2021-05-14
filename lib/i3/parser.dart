import 'dart:typed_data';

import 'package:flutbar/i3/utils/constants.dart';

String packInt(int size, int type) {
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

int unpackInt(String str) {
  var b1 = str.codeUnitAt(0) & 0xFF;
  var b2 = str.codeUnitAt(1) & 0xFF;
  var b3 = str.codeUnitAt(2) & 0xFF;
  var b4 = str.codeUnitAt(3) & 0xFF;

  return (((((b4 << 8) + b3) << 8) + b2) << 8) + b1;
}

String format(int type, {String payload = ''}) {
  var size = payload.length;
  String msg = MAGIC_STRING;
  msg += packInt(size, type);
  msg += payload;
  return msg;
}

class ParseResult {
  final bool event;
  final int size;
  final int type;
  final String response;
  ParseResult({this.event, this.size, this.response, this.type});

  String toString() =>
      "ParseResult:(event: $event, size: $size, type: $type, response: $response";
}

parse(Uint8List data) {
  String content = String.fromCharCodes(data);
  if (content.substring(0, MAGIC_STRING.length).toString() != MAGIC_STRING) {
    return {'error': 'wrong magic code'};
  }

  int size = unpackInt(content
      .substring(MAGIC_STRING.length, MAGIC_STRING.length + 4)
      .toString());
  int type = unpackInt(content
      .substring(MAGIC_STRING.length + 4, MAGIC_STRING.length + 8)
      .toString());
  String response = content.substring(MAGIC_STRING.length + 8, data.length);

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

  // print("event: $event");
  // print("type: $type");
  // print("size: $size");
  // print("response: $response");

  return new ParseResult(
      event: event, size: size, response: response, type: type);
}
