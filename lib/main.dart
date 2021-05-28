import 'package:flutbar/I3Widget.dart';
import 'package:flutbar/i3/connections/events.dart';
import 'package:flutbar/i3/connections/messages.dart';
import 'package:flutbar/ui/clock.dart';
import 'package:flutbar/ui/title.dart';
import 'package:flutbar/ui/workspace_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Flutbar());
}

class Flutbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      builder: (context, i3) {
        if (i3.hasData == false) {
          return Container(
            child: Text('Connecting to i3'),
          );
        }
        return I3Widget(
            messageConnection: i3.data?.first,
            eventsConnection: i3.data?.last,
            child: MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Scaffold(
                body: Center(child: Bar()),
              ),
            ));
      },
      future: Future.wait(
          [MessagesConnection.getInstance(), EventsConnection.getInstance()]),
    );
  }
}

class Bar extends StatelessWidget {
  const Bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 48, child: WorkspaceBar()),
            Container(
              child: TitleBar(),
            ),
            Container(
              child: Clock(),
            ),
          ],
        ));
  }
}
