import 'package:flutbar/I3Widget.dart';
import 'package:flutbar/i3/core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final I3Connection i3 = new I3Connection();
    return I3Widget(
        i3Service: i3,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: Center(child: MyHomePage()),
          ),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    I3Connection i3 = I3Widget.of(context).i3Service;
    return StreamBuilder<List<WorkSpace>>(
        stream: i3.getWorkspaces(),
        builder:
            (BuildContext context, AsyncSnapshot<List<WorkSpace>> snapshot) {
          print('rendering');
          if (snapshot.hasError) {
            return Container(child: Text('error'));
          } else if (snapshot.data == null) {
            return Container(child: Text('loading'));
          } else if (snapshot.data.length == 0) {
            return Container(child: Text('loading'));
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot?.data?.length ?? 0,
              itemBuilder: (context, index) {
                WorkSpace workspace = snapshot.data[index];
                return GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Text(workspace.name)
                        // Widget to display the list of project
                      ],
                    ),
                    onTap: () => i3.goToWorkspace(workspace.index));
              },
            );
          }
        });
  }
}
