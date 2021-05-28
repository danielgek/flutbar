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
          width: 48,
          height: 48,
          color: workspace.focused ? Colors.red : Colors.yellow,
          child: Text(workspace.name),
        ),
        onTap: () => i3.goToWorkspace(workspace.index));
  }
}
