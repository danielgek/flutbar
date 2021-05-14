import 'package:flutbar/i3/core.dart';
import 'package:flutbar/i3/models/workspace.dart';
import 'package:flutter/material.dart';

// format2(String str) {

//   return utf8.encode(str)
// }

void main() {
  I3Connection i3 = new I3Connection();

  // Future<RawSocket> rawConnection = RawSocket.connect(host, 0);
  // rawConnection.catchError((e) {
  //   print("Raw:Unable to connect: $e");
  //   exit(1);
  // });

  // rawConnection.then((socket) {
  //   print("Raw:connected");
  //   socket.listen((event) {
  //     print("Raw:");
  //     print(event);
  //   });
  //   List<int> message = List<int>.from(utf8.encode("i3-ipc 0 1"));
  //   // message.add(1);
  //   // message.add(0);
  //   print(utf8.decode(message));
  //   socket.write(message);
  // }).catchError((e) {
  //   print("Raw:Unable to connect: $e");
  //   exit(1);
  // });
  ;
  runApp(MyApp(i3));
}

class MyApp extends StatelessWidget {
  I3Connection i3;
  MyApp(I3Connection i3) {
    this.i3 = i3;
  }
  // MyApp({Key key, this.i3}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.i3}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final I3Connection i3;

  @override
  _MyHomePageState createState() => _MyHomePageState(this.i3);
}

class _MyHomePageState extends State<MyHomePage> {
  I3Connection i3;
  _MyHomePageState(I3Connection i3) {
    print("setting i3");
    print(i3);
    this.i3 = i3;
  }
  int _counter = 0;

  void _incrementCounter() {
    print('increment');
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Widget workspacesWidget() {
    I3Connection i3 = new I3Connection();
    return FutureBuilder<List<WorkSpace>>(
      builder: (context, workspacesSnapshot) {
        // if (workspacesSnapshot.connectionState == ConnectionState.none &&
        //     workspacesSnapshot.hasData == null) {
        //   //print('project snapshot data is: ${workspacesSnapshot.data}');
        //   return Container();
        // }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: workspacesSnapshot?.data?.length ?? 0,
          itemBuilder: (context, index) {
            WorkSpace workspace = workspacesSnapshot.data[index];
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
      },
      future: i3.getWorkspaces(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child:
              workspacesWidget()), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
