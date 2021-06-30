import 'package:flutbar/I3Widget.dart';
import 'package:flutbar/i3/models/messages/responses/workspaces_respose.dart';
import 'package:flutbar/ui/workspaces/workspace_item.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    I3Widget i3 = I3Widget.of(context);
    return StreamBuilder<String>(
        stream: i3.currentTitle,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasError) {
            return Container(child: Text('error'));
          } else if (snapshot.data == null) {
            return Container(child: Text('loading'));
          } else {
            return Container(
                child: Text(
              snapshot.data ?? 'no title ? this is wierd',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF707A8C)),
            ));
          }
        });
  }
}
