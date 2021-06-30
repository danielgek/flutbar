import 'package:flutbar/I3Widget.dart';
import 'package:flutbar/i3/models/messages/responses/workspaces_respose.dart';
import 'package:flutter/material.dart';

class WorkspaceBarBackground extends StatelessWidget {
  const WorkspaceBarBackground({Key? key, required this.workspace})
      : super(key: key);
  final WorkSpace workspace;
  @override
  Widget build(BuildContext context) {
    I3Widget i3 = I3Widget.of(context);
    return GestureDetector(
        child: Container(
          padding: EdgeInsets.all(5.5),
          // margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          width: 30,
          height: 30,
          alignment: Alignment.center,
          child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFF707A8C),
                  border: Border(
                    top: BorderSide
                        .none, // BorderSide(width: 0, color: Color(0x00FF0000)),
                    left: BorderSide
                        .none, // BorderSide(width: 0, color: Color(0xFFFFFFFF)),
                    right: BorderSide
                        .none, // BorderSide(width: 0, color: Color(0xFF000000)),
                    bottom: BorderSide
                        .none, //BorderSide(width: 2, color: Color(0xFF707A8C)),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(2)))),
        ),
        onTap: () => i3.goToWorkspace(workspace.index));
  }
}
