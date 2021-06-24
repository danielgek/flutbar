import 'dart:typed_data';

import 'package:flutbar/i3/utils/constants.dart';

String packInt(int size, int type) {
  String result = '';
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
  int b1 = str.codeUnitAt(0) & 0xFF;
  int b2 = str.codeUnitAt(1) & 0xFF;
  int b3 = str.codeUnitAt(2) & 0xFF;
  int b4 = str.codeUnitAt(3) & 0xFF;

  return (((((b4 << 8) + b3) << 8) + b2) << 8) + b1;
}

String format(int type, {String payload = ''}) {
  int size = payload.length;
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
  ParseResult(
      {required this.event,
      required this.size,
      required this.response,
      required this.type});

  String toString() => "ParseResult:(event: $event, size: $size, type: $type)";
}

List<ParseResult> parse(Uint8List data) {
  String content = String.fromCharCodes(data);
  return content.split(MAGIC_STRING).where((c) => c.length > 0).map((c) {
    int size = unpackInt(c.substring(0, 4));
    int type = unpackInt(c.substring(4, 8));

    String response = c.substring(8);

    bool event = (c.codeUnitAt(7) & 0x80) == 0x80;

    if (event) type = type = type & 0x7f;

    return new ParseResult(
        event: event, size: size, response: response, type: type);
  }).toList();
}
