import 'package:flutbar/I3Widget.dart';
import 'package:flutbar/i3/models/messages/responses/workspaces_respose.dart';
import 'package:flutter/material.dart';

class WorkspaceBarItem extends StatelessWidget {
  const WorkspaceBarItem({Key? key, required this.workspace}) : super(key: key);
  final WorkSpace workspace;
  @override
  Widget build(BuildContext context) {
    I3Widget i3 = I3Widget.of(context);
    return GestureDetector(
        child: Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          child: Text(workspace.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1f2430))),
        ),
        onTap: () => i3.goToWorkspace(workspace.index));
  }
}
