import 'package:async/async.dart';
import 'package:flutbar/i3/connections/messages.dart';
import 'package:flutbar/i3/connections/events.dart';
import 'package:flutbar/i3/models/events/window_event.dart';
import 'package:flutbar/i3/models/messages/responses/workspaces_respose.dart';
import 'package:flutbar/i3/utils/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'i3/models/common/node.dart';

class I3Widget extends InheritedWidget {
  I3Widget({
    required Widget child,
    required this.messageConnection,
    required this.eventsConnection,
  }) : super(child: child);

  final MessagesConnection messageConnection;
  final EventsConnection eventsConnection;

  static Future<I3Widget> connect(Widget child) async {
    final MessagesConnection i3messages =
        await MessagesConnection.getInstance();
    final EventsConnection i3events = await EventsConnection.getInstance();

    return I3Widget(
      eventsConnection: i3events,
      messageConnection: i3messages,
      child: child,
    );
  }

  static I3Widget of(BuildContext context) {
    final I3Widget? result =
        context.dependOnInheritedWidgetOfExactType<I3Widget>();
    assert(result != null, 'No I3Widget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant I3Widget oldWidget) {
    return false;
  }

  goToWorkspace(int index) {
    this.messageConnection.runCommands(['workspace number $index']);
  }

  Stream<List<WorkSpace>> get workspaces {
    this.eventsConnection.subscribe([EventsTypes.WORKSPACE]);

    return StreamGroup.merge([
      this
          .eventsConnection
          .workspcaceEvents
          .switchMap((value) => this.messageConnection.workspaces.asStream()),
      this.messageConnection.workspaces.asStream(),
    ]);
  }

  Node? searchFocusedNode(Node node) {
    if (node.focused) {
      return node;
    }
    if (node.nodes.isEmpty) return null;

    return node.nodes.map((element) {
      Node? n = searchFocusedNode(element);
      return n;
    }).fold(null, (prev, element) {
      return prev != null ? prev : element;
    });
  }

  Stream<String> get currentTitle {
    this.eventsConnection.subscribe([EventsTypes.WINDOW]);
    return StreamGroup.merge([
      this
          .eventsConnection
          .windowEvents
          .where((event) =>
              event.change == WindowChangeType.FOCUS ||
              event.change == WindowChangeType.TITLE)
          .map((event) => event.container.name != null
              ? (event.container.name as String)
              : 'error'),
      this.messageConnection.tree.asStream().map((value) {
        Node? focusedNode = searchFocusedNode(value);
        if (focusedNode != null && focusedNode.name != null) {
          return focusedNode.name as String;
        }
        return 'error';
      })
    ]);
  }
}
