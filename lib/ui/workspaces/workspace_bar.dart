import 'package:flutbar/I3Widget.dart';
import 'package:flutbar/i3/models/messages/responses/workspaces_respose.dart';
import 'package:flutbar/ui/workspaces/workspace_item.dart';
import 'package:flutbar/ui/workspaces/workspace_item_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WorkspaceBar extends StatefulWidget {
  @override
  _WorkspaceBar createState() => _WorkspaceBar();
}

class _WorkspaceBar extends State<WorkspaceBar> with TickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 200);
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    I3Widget i3 = I3Widget.of(context);
    return StreamBuilder<List<WorkSpace>>(
        stream: i3.workspaces,
        builder:
            (BuildContext context, AsyncSnapshot<List<WorkSpace>> snapshot) {
          if (snapshot.hasError) {
            return Container(child: Text('error'));
          } else if (snapshot.data == null) {
            return Container(child: Text('loading'));
          } else if ((snapshot.data ?? []).length == 0) {
            return Container(child: Text('no workspaces'));
          } else {
            List<WorkSpace> workspaces = (snapshot.data ?? []);

            return Listener(
              onPointerSignal: (PointerSignalEvent event) {
                if (event is PointerScrollEvent && event.down == false) {
                  int focusedWorkspaceIndex =
                      workspaces.indexWhere((w) => w.focused);
                  if (event.scrollDelta.dy > 20 &&
                      focusedWorkspaceIndex + 1 < workspaces.length) {
                    WorkSpace? nextWorkspace =
                        workspaces[focusedWorkspaceIndex + 1];
                    if (nextWorkspace is WorkSpace) {
                      i3.goToWorkspace(nextWorkspace.index);
                    }
                  } else if (event.scrollDelta.dy < -20 &&
                      focusedWorkspaceIndex - 1 >= 0) {
                    WorkSpace? previousWorkspace =
                        workspaces[focusedWorkspaceIndex - 1];
                    if (previousWorkspace is WorkSpace) {
                      i3.goToWorkspace(previousWorkspace.index);
                    }
                  }
                }
              },
              child: Stack(
                children: <Widget>[
                  Row(
                      children: workspaces
                          .map((workspace) =>
                              WorkspaceBarBackground(workspace: workspace))
                          .toList()),
                  AnimatedPositioned(
                    left: workspaces
                            .indexOf(workspaces.firstWhere(
                                (element) => element.focused == true))
                            .floorToDouble() *
                        28,
                    top: 0,
                    duration: duration,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      // margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFffcc66),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)))),
                    ),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: workspaces
                          .map((workspace) =>
                              WorkspaceBarItem(workspace: workspace))
                          .toList()),
                ],
              ),
            );
          }
        });
  }
}
