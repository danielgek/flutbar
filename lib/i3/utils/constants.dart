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
