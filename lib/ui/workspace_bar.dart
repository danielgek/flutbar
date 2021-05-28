import 'package:flutbar/I3Widget.dart';
import 'package:flutbar/i3/models/messages/responses/workspaces_respose.dart';
import 'package:flutbar/ui/workspace_item.dart';
import 'package:flutter/material.dart';

class WorkspaceBar extends StatelessWidget {
  const WorkspaceBar({Key? key}) : super(key: key);

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
            List<WorkspaceBarItem> workspaces = (snapshot.data ?? [])
                .map((workspace) => WorkspaceBarItem(workspace: workspace))
                .toList();
            return Row(children: workspaces);
          }
        });
  }
}
