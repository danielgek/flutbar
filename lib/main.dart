import 'package:flutbar/I3Widget.dart';
import 'package:flutbar/i3/connections/events.dart';
import 'package:flutbar/i3/connections/messages.dart';
import 'package:flutbar/ui/clock.dart';
import 'package:flutbar/ui/title.dart';
import 'package:flutbar/ui/workspaces/workspace_bar.dart';
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
          return MaterialApp(
              title: 'Connecting to i3',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Scaffold(
                body: Text('Connecting to i3'),
              ));
        }
        return I3Widget(
            messageConnection: i3.data?.first,
            eventsConnection: i3.data?.last,
            child: MaterialApp(
              title: 'Flutbar',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: 'RobotoMono',
              ),
              home: Scaffold(
                body: Bar(),
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
        height: 30,
        decoration: const BoxDecoration(
          color: Color(0xFF1f2430),
          border: Border(
            top: BorderSide
                .none, // BorderSide(width: 0, color: Color(0x00FF0000)),
            left: BorderSide
                .none, // BorderSide(width: 0, color: Color(0xFFFFFFFF)),
            right: BorderSide
                .none, // BorderSide(width: 0, color: Color(0xFF000000)),
            bottom: BorderSide(width: 2, color: Color(0xFF707A8C)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 30, alignment: Alignment.center, child: WorkspaceBar()),
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
